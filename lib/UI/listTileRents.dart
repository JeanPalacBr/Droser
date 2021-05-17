import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';

class ListTileRents extends StatelessWidget {
  Rented ren;
  ListTileRents(this.ren);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //BUSQUEDA POR CATEGORIA
      },
      child: ListTile(
        isThreeLine: true,
        title: Text("Articulo: " + ren.idarticulo),
        tileColor: Colors.white,
        subtitle: Text("Cantidad: " +
            ren.cantidad.toString() +
            "\n Fecha: " +
            ren.created),
        trailing:
            Text("\$" + ren.valor.toString() + "\n" + ren.estado.toString()),
      ),
    );
  }
}
