import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/UI/navDrawer.dart';

class About extends StatelessWidget {
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  About();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                        "Droser es un prototipo creado como parte del proyecto final para el titulo de Ingeniero de sistemas de la Universidad del norte. ha sido desarrollado por: \n\n Carlos De Jesus Montes Mendez \n Jean Palacio Bravo \n Pedro Luis Valega Ortiz  ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ))));
  }
}
