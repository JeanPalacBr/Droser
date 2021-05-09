import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/detailOfert.dart';

class CardOfert extends StatelessWidget {
  Ofert ofe;
  CardOfert(this.ofe);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailOfert(ofe)));
        },
        child: Card(
          margin: EdgeInsets.all(5),
          shadowColor: Colors.black,
          color: Colors.indigo[50],
          elevation: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Stack(
                    children: [
                      Image.network(
                        "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                        width: 400,
                        alignment: Alignment.center,
                      ),
                      if (ofe.dto == "0")
                        ...{}
                      else ...{
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                          child: Text(
                            "-" + ofe.dto.toString() + "%",
                            style: TextStyle(
                                backgroundColor: Colors.red,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        )
                      },
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ofe.nombre.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    if (ofe.dto == "0") ...{
                      Text(
                        "\$" + ofe.precio.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                        ),
                      ),
                    } else ...{
                      Text("\$" + ofe.precio.toString(),
                          style: TextStyle(
                              fontSize: 20.5,
                              color: Colors.black54,
                              decoration: TextDecoration.lineThrough)),
                      Text(
                        "\$" +
                            ((double.tryParse(ofe.precio.toString()) *
                                    ((100 - double.tryParse(ofe.dto)) / 100)))
                                .toString(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                        ),
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  // void dcto(){
  //   double dcto = ofe.dto;
  //   String finals="";

  // }
}
