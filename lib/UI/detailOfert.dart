import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/searchResult.dart';

Ofert ofera;

class DetailOfert extends StatefulWidget {
  Ofert ofer = new Ofert();
  DetailOfert(this.ofer);
  @override
  DetailOfertstate createState() => DetailOfertstate(this.ofer);
}

class DetailOfertstate extends State<DetailOfert> {
  Ofert ofer = new Ofert();
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;

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
          0.45,
          0.3,
          0.3
        ], begin: FractionalOffset.topRight, end: FractionalOffset.bottomLeft)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: !searching
                ? Text("Droser")
                : TextField(
                    controller: busqueda,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        hintText: "Busca drones, artículos y más...",
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white),
                    onSubmitted: (busqueda) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult(busqueda)));
                    },
                  ),
            actions: <Widget>[
              Row(
                children: [
                  IconButton(
                      icon:
                          !searching ? Icon(Icons.search) : Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          this.searching = !this.searching;
                          busqueda.clear();
                        });
                      }),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Carrito(carrito)));
                    },
                    icon: Icon(Icons.shopping_cart),
                  )
                ],
              )
            ],
            backgroundColor: Colors.blue[400],
            elevation: 0,
          ),
          drawer: NavDrawer(),
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
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
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          ofer.image == null
                              ? Image.network(
                                  "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                                  width: 250,
                                  alignment: Alignment.center,
                                )
                              : Image(
                                  image: ofer.image,
                                  width: 250,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fill,
                                ),
                          if (ofer.dto == "0")
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
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (ofer.dto == "0") ...{
                      Text(
                        "\$" + ofer.precio.toString(),
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                        ),
                      ),
                    } else ...{
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\$" + ofer.precio.toString(),
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black54,
                                    decoration: TextDecoration.lineThrough)),
                            Text(
                              "\$" +
                                  ((double.tryParse(ofer.precio.toString()) *
                                          ((100 - double.tryParse(ofer.dto)) /
                                              100)))
                                      .toString(),
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    },
                    Divider(thickness: 3),
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
                    Divider(thickness: 3),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.description),
                          Text(
                            "Descripción:",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        ofer.descripcion,
                        style: TextStyle(fontSize: 21),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Divider(thickness: 3),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.indigo[700]),
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
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        carrito.add(ofer);
                        subtotales.add(0);
                        cantidades.add("1");
                        fechainicio.add("1");
                        fechafin.add("1");
                        horainicio.add("1");
                        horafin.add("1");
                        formulariolleno.add(0);
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
