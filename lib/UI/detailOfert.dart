import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/navDrawer.dart';

Ofert ofera;

class DetailOfert extends StatefulWidget {
  Ofert ofer = new Ofert();

  //  = new Ofert(
  //     cantidad: 0,
  //     categoria: "",
  //     dto: "",
  //     descripcion: "",
  //     nombre: "a",
  //     precio: 0);

  DetailOfert(this.ofer);
  @override
  DetailOfertstate createState() => DetailOfertstate(this.ofer);
}

class DetailOfertstate extends State<DetailOfert> {
  Ofert ofer = new Ofert();

  DetailOfertstate(this.ofer);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue[400],
          Colors.blue[200],
          Colors.white,
        ], stops: [
          0.4,
          0.3,
          0.3
        ], begin: FractionalOffset.topRight, end: FractionalOffset.bottomLeft)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              elevation: 0,
              title: Text("Droser"),
              backgroundColor: Colors.blue[400],
              actions: <Widget>[
                Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    Text(
                      "Carrito",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ],
                ),
              ]),
          drawer: NavDrawer(),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Center(
                        child: new Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          height: 20.0,
                          width: 80.0,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                          width: 300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                        child: Text(
                          " " + ofer.nombre,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      if (ofer.dto.toString() == "0")
                        ...{}
                      else ...{
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                          child: Text(
                            "-" + ofer.dto.toString() + "%",
                            style: TextStyle(
                                backgroundColor: Colors.red,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        )
                      },
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (ofer.dto == "0") ...{},
                        Text(
                          "\$" + ofer.precio.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.category),
                              Text(
                                "Categoria: " + ofer.categoria,
                                style: TextStyle(fontSize: 21),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.description),
                              Text(
                                "Descripción: ",
                                style: TextStyle(fontSize: 21),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "" + ofer.descripcion,
                          style: TextStyle(fontSize: 21),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.event_available),
                        Text(
                          "Disponibilidad: " + ofer.cantidad.toString(),
                          style: TextStyle(fontSize: 21),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.indigo[700]),
                          //color: Colors.white,
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          label: Text("Agregar al carrito",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Agregado a carrito'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
