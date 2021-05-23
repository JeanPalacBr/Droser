import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';

class RentCard extends StatelessWidget {
  Rented rent;
  RentCard(this.rent);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Card(
          margin: EdgeInsets.all(15),
          shadowColor: Colors.black,
          color: Colors.blue[50],
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history),
                        Text(
                          "Hora y fecha de pedido: " + rent.created,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.av_timer_sharp),
                        Text(
                          "Fecha de inicio: " + rent.fechaInicio,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.av_timer_sharp),
                        Text(
                          "Fecha de fin: " + rent.fechaFin,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.av_timer_sharp),
                        Text(
                          "Hora de inicio: " + rent.horaInicio,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.av_timer_sharp),
                        Text(
                          "Hora de fin: " + rent.horaFin,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.money),
                        Text(
                          "Costo: \$" + rent.valor.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.format_list_numbered_sharp),
                        Text(
                          "Cantidad: " + rent.cantidad.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star),
                        Text(
                          "Estado: " + rent.estado.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
