import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/controlPanelRent.dart';

class ListTileRentspanel extends StatelessWidget {
  Rented ren;
  ListTileRentspanel(this.ren);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ControlPanelRent(ren)));
      },
      child: ListTile(
        isThreeLine: true,
        title: Text("Articulo: " + ren.idarticulo),
        tileColor: Colors.white,
        subtitle: Text("Cantidad: " +
            ren.cantidad.toString() +
            "\n Fecha: " +
            ren.created),
        trailing: Text("\$" +
            ren.valor.toString() +
            "\n" +
            (ren.estado == "1"
                ? "Pendiente"
                : ren.estado == "2"
                    ? "En curso"
                    : ren.estado == "3"
                        ? "Terminado"
                        : "Cancelado")),
      ),
    );
  }
}
