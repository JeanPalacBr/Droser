import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/carritoCard.dart';

import 'navDrawer.dart';

List<double> subtotales = <double>[];
List<String> cantidades = <String>[];
List<Map<String, String>> publicadosa = <Map<String, String>>[];

class Carrito extends StatefulWidget {
  final List<Ofert> carri;
  Carrito(this.carri);
  @override
  _CarritoState createState() => _CarritoState(this.carri);
}

class _CarritoState extends State<Carrito> {
  List<Ofert> carri = <Ofert>[];
  double apagar = 0;
  TextEditingController busqueda = new TextEditingController();
  _CarritoState(this.carri);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text("Carrito"), backgroundColor: Colors.red[400]),
      body: Builder(
        builder: (context) => Column(
          children: [
            Row(
              children: <Widget>[
                FlatButton(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      setState(() {
                        carri.clear();
                        subtotales.clear();
                        cantidades.clear();
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.remove_shopping_cart),
                        Text("Limpiar carrito")
                      ],
                    )),
                Text("Total a pagar: " + apagar.toString()),
              ],
            ),
            Expanded(child: _listArticulos()),
            FlatButton(
                color: Colors.grey[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  setState(() {
                    sumatoria();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(Icons.refresh), Text("Actualizar")],
                )),
            FlatButton(
                color: Colors.grey[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(Icons.check), Text("Guardar lista")],
                ))
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
    return carri.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: carri.length,
            itemBuilder: (context, posicion) {
              return CarritoCard(carri[posicion], posicion);
            })
        : Container();
  }
}
