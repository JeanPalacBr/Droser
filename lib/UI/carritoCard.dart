import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/Carrito.dart';

class CarritoCard extends StatefulWidget {
  final Ofert articulo;
  final int posx;
  CarritoCard(this.articulo, this.posx);
  @override
  CarritoCardState createState() => CarritoCardState(this.articulo, this.posx);
}

class CarritoCardState extends State<CarritoCard> {
  final Ofert articulo;
  final cantidade = TextEditingController();
  double subtotal = 0;
  int posx;
  CarritoCardState(this.articulo, this.posx);
  @override
  void initState() {
    super.initState();
    subtotales.add(0);
    cantidades.add("1");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.red[400],
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                padding(
                    Text("Nombre: " + articulo.nombre,
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    1),
                Text("Categoría: " + articulo.categoria,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
                Text("Precio: " + articulo.precio.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
                padding(
                    Text("Subtotal: " + subtotal.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18.0)),
                    2),
                Row(
                  children: <Widget>[
                    Text("Ingrese la cantidad: ",
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  if (text != null) {
                                    sbtotal(articulo.precio.toDouble(),
                                        int.parse(text));
                                    subtotales[posx] = subtotal;
                                    cantidades[posx] = text;
                                  }
                                });
                              },
                              controller: cantidade,
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black))),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )));
  }

  void sbtotal(double precio, int cantidad) {
    subtotal = precio * cantidad;
  }

  Widget padding(Widget widget, int t, [String typeTodo]) {
    Widget pa;
    switch (t) {
      case 1:
        pa =
            Padding(padding: EdgeInsets.fromLTRB(10, 30, 10, 5), child: widget);
        break;
      case 2:
        pa =
            Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 30), child: widget);
        break;
    }

    return pa;
  }
}
