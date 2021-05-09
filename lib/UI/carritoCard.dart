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
        color: Colors.blue[400],
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                    width: 100,
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(articulo.nombre,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text("Categoría: " + articulo.categoria,
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                      Text(
                          "Precio: " +
                              (double.parse(articulo.precio.toString()) *
                                      ((100 -
                                              double.tryParse(
                                                  articulo.dto.toString())) /
                                          100))
                                  .toString(),
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                      Text("Subtotal: " + subtotal.toString(),
                          style:
                              TextStyle(color: Colors.black, fontSize: 18.0)),
                      Row(
                        children: <Widget>[
                          Text("Horas a rentar: ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 2, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: 80,
                                  height: 40,
                                  child: TextField(
                                    onChanged: (text) {
                                      setState(() {
                                        if (text != null) {
                                          sbtotal(articulo.precio.toDouble(),
                                              int.parse(text));
                                          subtotales[posx] = subtotal;
                                          cantidades[posx] = text;
                                          sumatoria();
                                        }
                                      });
                                    },
                                    controller: cantidade,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white))),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )));
  }

  void sbtotal(double precio, int cantidad) {
    subtotal = precio * cantidad;
  }

  void sumatoria() {
    for (var i = 0; i < subtotales.length; i++) {
      apagar = apagar + subtotales[i];
    }
  }
}
