import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/components/custom_dropdown.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/components/custom_text_form_field.dart';
import 'package:gas_calculator/models/fuel_type_model.dart';
import 'package:gas_calculator/stores/home_store/home_store.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class RefuelPage extends StatefulWidget {
  final String label;
  final bool edit;

  RefuelPage({this.label = "", this.edit = false});

  @override
  _RefuelPageState createState() => _RefuelPageState();
}

class _RefuelPageState extends State<RefuelPage> {
  final HomeStore homeStore = GetIt.I<HomeStore>();
  final RefuelStore refuelStore = GetIt.I<RefuelStore>();
  final VehicleStore vehicleStore = GetIt.I<VehicleStore>();
  final _key = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final DateTime currentDate = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final MaskTextInputFormatter maskDateFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  final MaskTextInputFormatter maskHourFormatter =
      MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  final DateFormat hourFormatter = DateFormat('HH:mm');

  late final String initialDate;
  late final String initialHour;
  bool showModal = false;

  Future datePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());

    if (date != null) {
      dateController.text = dateFormatter.format(date);
    }
    showModal = false;
  }

  Future timePicker(BuildContext context) async {
    var selectedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
        initialEntryMode: TimePickerEntryMode.input);

    if (selectedTime != null) {
      timeController.text = "${selectedTime.hour}:${selectedTime.minute}";
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.edit) {
      refuelStore.litresInputController.text =
          "${refuelStore.currentRefuel.litres}";
      refuelStore.totalInputController.text =
          "${refuelStore.currentRefuel.totalCost}";
      refuelStore.priceInputController.text =
          "${refuelStore.currentRefuel.price}";
      var date =
          DateFormat("dd/MM/yyyy hh:mm").parse(refuelStore.currentRefuel.date);

      dateController.text = dateFormatter.format(date);
      timeController.text = hourFormatter.format(date);
    } else {
      refuelStore.priceInputController.text = "${refuelStore.lastRefuel.price}";
      dateController.text = dateFormatter.format(currentDate);
      timeController.text = hourFormatter.format(currentDate);
    }

    var fuelTypeId = widget.edit
        ? refuelStore.currentRefuel.fuelTypeId
        : vehicleStore.selectedVehicle.fuelTypeId;
    refuelStore.setCurrentFuelType(refuelStore.fuelTypeList
        .firstWhere((element) => element.id == fuelTypeId));
    refuelStore.currentRefuel.fuelTypeId = refuelStore.currentFuelType.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Flexible(
                          child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Row(children: [
                          IconButton(
                              icon: Icon(Icons.today),
                              onPressed: () {
                                datePicker(context);
                              }),
                          Flexible(
                            child: CustomTextFormField(
                              hint: "Date",
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [maskDateFormatter],
                              onSaved: (value) {
                                if (value != null) refuelStore.date = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Fill this field";
                                }

                                if (value.toString().length != 10) {
                                  return "Invalid date";
                                }

                                try {
                                  var date = DateFormat("dd/MM/yyyy")
                                      .parseStrict(value);

                                  if (!date.isBefore(DateTime.now())) {
                                    return "Future date not allowed";
                                  }
                                } catch (e) {
                                  return "Invalid date";
                                }
                              },
                            ),
                          )
                        ]),
                      )),
                      Flexible(
                          child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.access_time_outlined),
                                      onPressed: () {
                                        timePicker(context);
                                      }),
                                  Flexible(
                                      child: CustomTextFormField(
                                    hint: "Time",
                                    keyboardType: TextInputType.datetime,
                                    controller: timeController,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [maskHourFormatter],
                                    onSaved: (value) {
                                      if (value != null)
                                        refuelStore.time = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Fill this field";
                                      }
                                      var stringValue = value.toString();
                                      var hours = stringValue.split(":").first;
                                      var minutes = stringValue.split(":").last;

                                      if (hours.length != 2 ||
                                          int.parse(hours) > 23) {
                                        return "Incorrect time";
                                      }
                                      if (!stringValue.contains(":") ||
                                          minutes.length != 2 ||
                                          int.parse(minutes) > 59) {
                                        return "Incorrect time";
                                      }
                                    },
                                  ))
                                ],
                              )))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextFormField(
                        hint: "Odometer(km)",
                        keyboardType: TextInputType.number,
                        initialValue: "${refuelStore.currentRefuel.odometer}",
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                              decimalDigits: 2, symbol: "")
                        ],
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          if (value != null)
                            refuelStore.currentRefuel.odometer =
                                double.parse(value.replaceAll(",", ""));
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Fill this field";
                          }
                          if (refuelStore.lastRefuel.id != null) {
                            if (double.parse(value) <=
                                refuelStore.lastRefuel.odometer) {
                              return "Odometer should be bigger than last refuel";
                            }
                          }
                        },
                      ),
                      Visibility(
                          visible: refuelStore.lastRefuel.id != null,
                          child: Text(
                              "Last odometer: ${refuelStore.lastRefuel.odometer}"))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Observer(
                      builder: (_) => CustomDropdown(
                        value: refuelStore.currentFuelType.id > 0
                            ? refuelStore.currentFuelType
                            : refuelStore.fuelTypeList[0],
                        dropdownMenuItemList: refuelStore.fuelTypeDrodownList,
                        onChanged: (FuelType? value) {
                          if (value != null) {
                            refuelStore.setCurrentFuelType(value);
                            refuelStore.currentRefuel.fuelTypeId = value.id;
                            refuelStore
                                .setCurrentRefuel(refuelStore.currentRefuel);
                            vehicleStore.selectedVehicle.fuelTypeId = value.id;
                            vehicleStore.setSelectedVehicle(
                                vehicleStore.selectedVehicle);
                          }
                        },
                        isEnabled: true,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Focus(
                              child: CustomTextFormField(
                                hint: "Price/L",
                                controller: refuelStore.priceInputController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                      decimalDigits: 3, symbol: "")
                                ],
                                onSaved: (value) {
                                  if (value != null)
                                    refuelStore.currentRefuel.price =
                                        double.parse(value.replaceAll(",", ""));
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill this field";
                                  }
                                },
                              ),
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  refuelStore.fillLastInput();
                                }
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Focus(
                              child: CustomTextFormField(
                                hint: "Total cost",
                                controller: refuelStore.totalInputController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                      decimalDigits: 3, symbol: "")
                                ],
                                onSaved: (value) {
                                  if (value != null)
                                    refuelStore.currentRefuel.totalCost =
                                        double.parse(value.replaceAll(",", ""));
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill this field";
                                  }
                                },
                              ),
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  refuelStore.fillLastInput();
                                }
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Focus(
                              child: CustomTextFormField(
                                hint: "Litres",
                                controller: refuelStore.litresInputController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                textInputAction: TextInputAction.done,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                      decimalDigits: 3, symbol: "")
                                ],
                                onSaved: (value) {
                                  if (value != null)
                                    refuelStore.currentRefuel.litres =
                                        double.parse(value.replaceAll(",", ""));
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill this field";
                                  }
                                },
                              ),
                              onFocusChange: (hasFocus) {
                                if (!hasFocus) {
                                  refuelStore.fillLastInput();
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Observer(
                            builder: (_) => Transform.scale(
                              alignment: Alignment.centerLeft,
                              scale: 0.8,
                              child: CupertinoSwitch(
                                activeColor: kDarkBlueColor,
                                value: refuelStore.currentRefuel.isFillingUp,
                                onChanged: (value) {
                                  refuelStore.currentRefuel.isFillingUp =
                                      !refuelStore.currentRefuel.isFillingUp;

                                  refuelStore.setCurrentRefuel(
                                      refuelStore.currentRefuel);
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text("Are you filling the tank?"),
                          )
                        ],
                      ),
                      Text(
                        "Consumption is calculated between two full tanks",
                        style: TextStyle(
                            color: kLightGrey, fontSize: CustomFontSize.small),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: SubmitButton(
                    text: "Save",
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        refuelStore.currentRefuel.date =
                            '${refuelStore.date} ${refuelStore.time}';
                        refuelStore.currentRefuel.vehicleId =
                            vehicleStore.selectedVehicle.id!;
                        var refuel = await refuelStore.saveRefuel();

                        if (refuel.id == null) {
                          //exibe mensagem de erro
                        } else {
                          // refuelStore.setCurrent

                          refuelStore.getRefuels(
                              vehicleId: vehicleStore.selectedVehicle.id!);
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: widget.edit,
                  child: SubmitButton(
                    text: "Delete",
                    onPressed: () async {
                      bool? result = await homeStore.showConfirmationDialog(
                              context: context,
                              title: "Do you really want to delete?",
                              description: "",
                              confirmButton: "Yes",
                              cancelButton: "No") ??
                          false;

                      if (result) {
                        var success = await refuelStore
                            .deleteRefuel(refuelStore.currentRefuel.id!);
                        if (success) {
                          refuelStore.getRefuels(
                              vehicleId: vehicleStore.selectedVehicle.id!);
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
