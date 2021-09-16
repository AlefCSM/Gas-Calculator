import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/components/custom_text_form_field.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:get_it/get_it.dart';

class VehiclePage extends StatefulWidget {
  final String label;
  final bool firstVehicle;
  final bool edit;

  const VehiclePage(
      {Key? key, this.label = "", this.firstVehicle = false, this.edit = false})
      : super(key: key);

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  bool success = false;
  final _key = GlobalKey<FormState>();

  final RefuelStore refuelStore = GetIt.I<RefuelStore>();
  final VehicleStore vehicleStore = GetIt.I<VehicleStore>();

  close(bool success, BuildContext context) async {
    if (success) {
      await vehicleStore.getVehicles();
      if (vehicleStore.vehiclesList.length == 1) {
        vehicleStore.updateSelectedVehicle(vehicleStore.vehiclesList[0].id!);
        vehicleStore.buildDropdownList();
      }
      Navigator.of(context).pop();
    } else {
      // exibir mensagem de erro
    }
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
                child: CustomTextFormField(
                  hint: "Vehicle name",
                  initialValue: vehicleStore.currentVehicle.name,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    if (value != null) vehicleStore.currentVehicle.name = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Fill this field";
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: CustomTextFormField(
                  hint: "Fuel capacity (L)",
                  inputFormatters: [
                    CurrencyTextInputFormatter(decimalDigits: 2, symbol: "")
                  ],
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  initialValue: "${vehicleStore.currentVehicle.fuelCapacity}",
                  onSaved: (value) {
                    if (value != null)
                      vehicleStore.currentVehicle.fuelCapacity =
                          double.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Fill this field";
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: SubmitButton(
                  text: "Save",
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();

                      if (widget.edit) {
                        success = await vehicleStore.editVehicle();
                      } else {
                        success = await vehicleStore.saveVehicle();
                      }

                      close(success, context);
                    }
                  },
                ),
              ),
              Visibility(
                visible: widget.edit,
                child: SubmitButton(
                  text: "Delete",
                  onPressed: () async {
                    await refuelStore.deleteRefuelsFromVehicle(
                        vehicleStore.currentVehicle.id!);
                    success = await vehicleStore.deleteVehicle();
                    close(success, context);
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
