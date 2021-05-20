import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/UI/ConfirmRentDialog.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

class PayCardDialog extends StatefulWidget {
  const PayCardDialog();

  @override
  _PayCardDialogState createState() => _PayCardDialogState();
}

class _PayCardDialogState extends State<PayCardDialog> {
  final cvc = new TextEditingController();
  final fe = new TextEditingController();
  final nt = new TextEditingController();
  String hin = "Seleccione tipo de tarjeta";
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Pago con tarjeta",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                      new DropdownButton<String>(
                        hint: Text(hin),
                        items:
                            <String>['Credito', 'Débito'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            hin = value.toString();
                          });
                        },
                      ),
                      TextField(
                          cursorColor: Colors.white,
                          controller: nt,
                          maxLength: 16,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: "Número de tarjeta",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Número de tarjeta",
                            hintStyle: TextStyle(color: Colors.black),
                          )),
                      TextField(
                          cursorColor: Colors.white,
                          controller: cvc,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: "CVC",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "CVC",
                            hintStyle: TextStyle(color: Colors.black),
                          )),
                      TextField(
                          cursorColor: Colors.white,
                          controller: fe,
                          maxLength: 10,
                          keyboardType: TextInputType.datetime,
                          decoration: new InputDecoration(
                            labelText: "Fecha de expiración",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Fecha de expiración",
                            hintStyle: TextStyle(color: Colors.black),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancelar",
                                style: TextStyle(fontSize: 18),
                              )),
                          TextButton(
                              onPressed: () async {
                                SharedPrefs shar = new SharedPrefs();
                                int contad = 0;
                                int finn = 0;
                                for (var i = 0; i < disponibles.length; i++) {
                                  await for (String res in rent(
                                      disponibles[i], shar.token, context)) {
                                    // sleep(new Duration(seconds: 5));
                                    if (res == "Renta creado") {
                                      contad++;
                                    } else {
                                      if (res != null) {
                                        contad--;
                                      }
                                    }
                                  }

                                  finn++;
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmRentDialog(true);
                                  },
                                );
                                //Navigator.of(context).pop();
                              },
                              child: Text(
                                "Aceptar",
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 0,
                child: Icon(
                  Icons.credit_card_outlined,
                  color: Colors.black,
                  size: 100,
                ))
          ],
        ));
  }
}
