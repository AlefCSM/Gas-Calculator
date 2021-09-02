import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/components/custom_dropdown.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/components/custom_text_form_field.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class RefuelPage extends StatefulWidget {
  final String label;

  RefuelPage({this.label = ""});

  @override
  _RefuelPageState createState() => _RefuelPageState();
}

class _RefuelPageState extends State<RefuelPage> {
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

  String initialDate;
  String initialHour;
  bool showModal = false;

  Future<void> datePicker(BuildContext context) async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());

    if (date != null) {
      dateController.text = dateFormatter.format(date);
    }
    showModal = false;
  }

  Future<void> timePicker(BuildContext context) async {
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
    initialDate = dateFormatter.format(currentDate);
    initialHour = hourFormatter.format(currentDate);
    dateController.text = initialDate;
    timeController.text = initialHour;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      body: Container(
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
                            onSaved: (value) => refuelStore.date = value,
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return "Fill this field";
                              }

                              if (value.toString().length != 10) {
                                return "Invalid date";
                              }

                              try {
                                var date =
                                    DateFormat("dd/MM/yyyy").parseStrict(value);

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
                                  onSaved: (value) => refuelStore.time = value,
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
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
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        CurrencyTextInputFormatter(decimalDigits: 2, symbol: "")
                      ],
                      textInputAction: TextInputAction.next,
                      onSaved: (String value) => refuelStore.currentRefuel
                          .odometer = double.parse(value.replaceAll(",", "")),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "Fill this field";
                        }
                        if (refuelStore.lastRefuel.id > 0) {
                          if (double.parse(value) <=
                              refuelStore.lastRefuel.odometer) {
                            return "Odometer should be bigger than last refuel";
                          }
                        }
                      },
                    ),
                    Visibility(
                        visible: refuelStore.lastRefuel.id > 0,
                        child: Text(
                            "Last odometer: ${refuelStore.lastRefuel.odometer}"))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Observer(
                    builder: (_) => CustomDropdown(
                      value: refuelStore.currentFuelType ??
                          refuelStore.fuelTypeList[0],
                      dropdownMenuItemList: refuelStore.fuelTypeDrodownList,
                      onChanged: (value) {
                        refuelStore.currentRefuel.fuelTypeId = value.id;
                        refuelStore.setCurrentRefuel(refuelStore.currentRefuel);
                        refuelStore.setCurrentFuelType(value);
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
                              onSaved: (String value) =>
                                  refuelStore.currentRefuel.price =
                                      double.parse(value.replaceAll(",", "")),
                              validator: (value) {
                                if (value.isEmpty || value == null) {
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
                              onSaved: (String value) =>
                                  refuelStore.currentRefuel.totalCost =
                                      double.parse(value.replaceAll(",", "")),
                              validator: (value) {
                                if (value.isEmpty || value == null) {
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
                              onSaved: (String value) =>
                                  refuelStore.currentRefuel.litres =
                                      double.parse(value.replaceAll(",", "")),
                              validator: (value) {
                                if (value.isEmpty || value == null) {
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
                child: SubmitButton(
                  text: "save",
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      refuelStore.currentRefuel.date =
                          '${refuelStore.date} ${refuelStore.time}';
                      refuelStore.currentRefuel.vehicleId =
                          vehicleStore.selectedVehicle.id;
                      var saved = await refuelStore.saveVehicle();

                      if (saved == null) {
                        //exibe mensagem de erro
                      } else {
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
    );
  }
}
