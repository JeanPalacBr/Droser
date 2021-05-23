import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BurbujaMensaje extends StatelessWidget {
  String mensaje;
  bool enviadopor;

  BurbujaMensaje(this.mensaje, this.enviadopor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: enviadopor ? 0 : 24,
          right: enviadopor ? 24 : 0),
      alignment: enviadopor ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            enviadopor ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          color: enviadopor ? Colors.blue[300] : Colors.grey[400],
          borderRadius: enviadopor
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
        ),
        child: Text(mensaje,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            )),
      ),
    );
  }
}
