import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardOfert extends StatelessWidget {
  CardOfert();
  @override
  Widget build(BuildContext context) {
    //final acStates = Provider.of<AccountState>(context);
    return InkWell(
        onTap: () {},
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
                padding: const EdgeInsets.only(left: 25, top: 5),
                child: Text(
                  "Oferta del día",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                        child: Text(
                          "-30%",
                          style: TextStyle(
                              backgroundColor: Colors.red,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
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
                      "Drone quadcoptero DJI BoxMaster 5000",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text("\$250000",
                        style: TextStyle(
                            fontSize: 20.5,
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough)),
                    Text(
                      "\$175000",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                      //color: Colors.white,
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      label: Text("Agregar al carrito",
                          style: TextStyle(
                            // fontFamily: 'Product Sans',
                            //fontSize: 25,
                            color: Colors.white,
                          )),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
