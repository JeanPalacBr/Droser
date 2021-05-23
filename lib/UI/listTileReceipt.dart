import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/home.dart';

class ListTileReceipt extends StatelessWidget {
  Rent ren;
  int pos;
  ListTileReceipt(this.ren, this.pos);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        title: Text(carrito[pos].nombre),
        subtitle: Text("Cantidad: " + ren.cantidad.toString()),
        trailing: Text(ren.valor.toString()),
      ),
    );
  }
}
