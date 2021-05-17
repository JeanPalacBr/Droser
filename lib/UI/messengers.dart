import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/navDrawer.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Messengers extends StatelessWidget {
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  final contr = new TextEditingController();
  Messengers();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.white, Colors.blue[200], Colors.blue[400]],
              stops: [0.1, 0.3, 0.7],
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
            )),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                drawer: NavDrawer(),
                appBar: AppBar(
                  title: Text("Droser"),
                  backgroundColor: Colors.blue[400],
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Contacta con Droser a través de un mensaje, nuestro equipo te contactará muy prontamente",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      containerText(TextField(
                          cursorColor: Colors.white,
                          controller: contr,
                          autocorrect: true,
                          showCursor: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 2000,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(MaterialCommunityIcons.whatsapp,
                                    color: Colors.black),
                                label: Text("Enviar por \n Whatsapp",
                                    style: TextStyle(color: Colors.black))),
                            ElevatedButton.icon(
                                onPressed: () {
                                  droserBotCS(" Enviado por: " +
                                      usuario.nombre +
                                      "\n Email: " +
                                      usuario.email +
                                      "\n Telefono: " +
                                      usuario.telefono +
                                      "\n Mensaje: " +
                                      "\n " +
                                      contr.value.text.toString());
                                },
                                icon: Icon(Icons.send, color: Colors.black),
                                label: Text("Enviar",
                                    style: TextStyle(color: Colors.black))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  Widget containerText(Widget widg) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: widg,
    );
  }
}
