import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/payment.dart';
import 'package:lease_drones/UI/searchResult.dart';

class Receipt extends StatefulWidget {
  List<Rent> rents = <Rent>[];
  Receipt(this.rents);

  @override
  Receiptstate createState() => Receiptstate(this.rents);
}

class Receiptstate extends State<Receipt> {
  List<Rent> rents = <Rent>[];
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;

  Receiptstate(this.rents);
  @override
  void initState() {
    // Rent r = new Rent(cantidad: 3, valor: 10000, idarticulo: "1");
    // Rent r2 = new Rent(cantidad: 3, valor: 10000, idarticulo: "1");
    // Rent r3 = new Rent(cantidad: 3, valor: 10000, idarticulo: "1");
    // rents.add(r);
    // rents.add(r2);
    // rents.add(r3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.blue[500], Colors.blue[900]],
                stops: [0.1, 0.3, 0.7],
                begin: FractionalOffset.bottomLeft,
                end: FractionalOffset.topRight)),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: NavDrawer(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Card(
                  margin: EdgeInsets.all(20),
                  shadowColor: Colors.black,
                  color: Colors.indigo[50],
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image:
                                  AssetImage("assets/images/DroneLeaser.png"),
                              width: 70,
                            ),
                            Text(DateTime.now().toString().substring(0, 19)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Apreciado(a) " + usuario.nombre,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Usted ha rentado " +
                              rents.length.toString() +
                              " articulo(s) desde nuestra aplicación",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          " Orden",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: _list()),
                      Divider(
                        thickness: 3,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "TOTAL",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              total(),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.monetization_on_outlined),
                            label: Text(
                              "Ir a pagar",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigo[700]),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Pay()));
                            },
                          )),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String total() {
    String t;
    double sum = 0;
    for (var i = 0; i < rents.length; i++) {
      sum = sum + rents[i].valor;
    }
    t = sum.toString();
    return t;
  }

  Widget _list() {
    return ListView.builder(
        itemCount: rents.length,
        itemBuilder: (context, posicion) {
          return Container(
            color: Colors.white10,
            alignment: AlignmentDirectional.centerStart,
            child: ListTile(
              title: Text(carrito[posicion].nombre),
              subtitle:
                  Text("Cantidad: " + rents[posicion].cantidad.toString()),
              trailing: Text("\$" + rents[posicion].valor.toString()),
            ),
          );
        });
  }
}
