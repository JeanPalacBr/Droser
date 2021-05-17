import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';

class couponCard extends StatelessWidget {
  Coupon cou;
  couponCard(this.cou);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          //BUSQUEDA POR CATEGORIA
        },
        child: Card(
          margin: EdgeInsets.all(20),
          shadowColor: Colors.black,
          color: Colors.indigo[50],
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Cupón " + cou.nombre,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Redime este cupón y obten " +
                        cou.dcto.toString() +
                        "% de descuento en el producto mas costoso de tu renta. Escribe el codigo al momento de realizar el pago de tus artículos.",
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
                    cou.codigo,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Promoción valida hasta agotar inventario",
                    style: TextStyle(fontSize: 5, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
