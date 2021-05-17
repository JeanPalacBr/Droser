import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmRentDialog extends StatefulWidget {
  bool rentado = false;
  ConfirmRentDialog(this.rentado);

  @override
  _ConfirmRentDialogState createState() =>
      _ConfirmRentDialogState(this.rentado);
}

class _ConfirmRentDialogState extends State<ConfirmRentDialog> {
  bool rentado = false;
  final cvc = new TextEditingController();
  final fe = new TextEditingController();
  final nt = new TextEditingController();
  String hin = "Seleccione tipo de tarjeta";
  @override
  _ConfirmRentDialogState(this.rentado);
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
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 70, 15, 15),
                child: Text(
                    rentado
                        ? "Renta confirmada."
                        : "La solicitud de renta ha fallado, se ha cancelado el pago.",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center),
              ),
            ),
            Positioned(
              top: 10,
              child: rentado
                  ? Icon(Icons.check, color: Colors.green, size: 100)
                  : Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 100,
                    ),
            )
          ],
        ));
  }
}
