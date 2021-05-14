import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/UI/Carrito.dart';
import 'package:lease_drones/Services/APIcon.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox(
      {Key key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final cvc = new TextEditingController();
  final fe = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Pago con tarjeta",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  new DropdownButton<String>(
                    hint: Text("Seleccione tipo de tarjeta"),
                    items: <String>['Credito', 'Débito'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ],
              ),
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
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: "Fecha de expiración",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Fecha de expiración",
                    hintStyle: TextStyle(color: Colors.black),
                  )),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Row(
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
                      onPressed: () {
                        String r = "";
                        int contad = 0;
                        for (var i = 0; i < disponibles.length; i++) {
                          rent(disponibles[i]).then((ren) {
                            r = ren;
                            if (r == "Renta creado") {
                              contad++;
                            }
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Aceptar",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
