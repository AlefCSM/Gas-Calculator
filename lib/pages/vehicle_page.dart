import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/components/custom_text_form_field.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:get_it/get_it.dart';

class VehiclePage extends StatelessWidget {
  final String label;
  final bool firstVehicle;
  final _key = GlobalKey<FormState>();

  VehiclePage({this.label = "", this.firstVehicle =false});

  final VehicleStore vehicleStore = GetIt.I<VehicleStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
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
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => vehicleStore.currentVehicle.name = value,
                  validator: (value) {
                    if (value.isEmpty || value == null) {
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
                  onSaved: (value) => vehicleStore.currentVehicle.fuelCapacity = double.parse(value),
                  validator: (value) {
                    if (value.isEmpty || value == null) {
                      return "Fill this field";
                    }
                  },
                ),
              ),
              Container(
                child: SubmitButton(
                  text: "Add",
                  onPressed: () {
                    if(_key.currentState.validate()){
                      _key.currentState.save();
                      var teste = vehicleStore.saveVehicle();

                      if(teste == null){
                        //exibir mensagem de erro
                      }
                      else{
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ),
              Container(
                child: SubmitButton(
                  text: "teste",
                  onPressed: () {

                      vehicleStore.getVehicles();

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
