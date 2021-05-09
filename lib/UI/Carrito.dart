import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/carritoCard.dart';
import 'navDrawer.dart';

List<double> subtotales = <double>[];
List<String> cantidades = <String>[];
List<Map<String, String>> publicadosa = <Map<String, String>>[];
double apagar;

class Carrito extends StatefulWidget {
  final List<Ofert> carri;
  Carrito(this.carri);
  @override
  _CarritoState createState() => _CarritoState(this.carri);
}

class _CarritoState extends State<Carrito> {
  List<Ofert> carri = <Ofert>[];

  TextEditingController busqueda = new TextEditingController();
  _CarritoState(this.carri);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text("Carrito"), backgroundColor: Colors.blue[400]),
      body: Builder(
        builder: (context) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                  icon: Icon(Icons.remove_shopping_cart),
                  label: Text("Limpiar carrito"),
                  onPressed: () {
                    setState(() {
                      carri.clear();
                      subtotales.clear();
                      cantidades.clear();
                      apagar = 0;
                    });
                  },
                ),
                Text("Total a pagar: " + apagar.toString()),
              ],
            ),
            Expanded(child: _listArticulos()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.refresh),
                    label: Text(
                      "Actualizar carrito",
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                    onPressed: () {
                      setState(() {
                        sumatoria();
                      });
                    },
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.monetization_on_outlined),
                    label: Text(
                      "Ir a pagar",
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                    onPressed: () {
                      // try{
                      for (var i = 0; i < carri.length; i++) {
                        Map<String, String> articulo = {
                          "nombre": carri[i].nombre,
                          "categoria": carri[i].categoria,
                          "precio": carri[i].precio.toString(),
                          "cantidad": cantidades[i]
                        };
                        setState(() {
                          publicadosa.add(articulo);
                        });
                      }
                      // }catch(e){}
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sumatoria() {
    for (var i = 0; i < subtotales.length; i++) {
      apagar = apagar + subtotales[i];
    }
  }

  Widget _listArticulos() {
    return ListView.builder(
      itemCount: carri.length,
      itemBuilder: (context, posicion) {
        var element = carri[posicion];
        return Dismissible(
          key: UniqueKey(),
          background: Container(
              color: Colors.red,
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  Text(
                    "Borrar articulo",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
          child: CarritoCard(carri[posicion], posicion),
          onDismissed: (direction) {
            setState(() {
              carri.removeAt(posicion);
            });
          },
        );
      },
    );
  }
}
