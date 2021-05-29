import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/detailOfert.dart';
import 'package:lease_drones/UI/home.dart';

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
          margin: EdgeInsets.all(15),
          shadowColor: Colors.black,
          color: Colors.white,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      ofe.image == null
                          ? Image.network(
                              "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                              width: 400,
                              alignment: Alignment.center,
                            )
                          : Image(
                              image: ofe.image,
                              width: 400,
                              alignment: Alignment.center,
                              fit: BoxFit.fill,
                            ),
                      if (ofe.dto == "0")
                        ...{}
                      else ...{
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                          child: Text(
                            "-" + ofe.dto + "%",
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
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 20),
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
                        "\$" + ofe.precio + "/hora",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    } else ...{
                      Text("\$" + ofe.precio,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              decoration: TextDecoration.lineThrough)),
                      Text(
                        "\$" +
                            ((double.tryParse(ofe.precio) *
                                    ((100 - double.tryParse(ofe.dto)) / 100)))
                                .toString() +
                            "/hora",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    }
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      label: Text("Agregar al carrito",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        carrito.add(ofe);
                        subtotales.add(0);
                        cantidades.add("1");
                        fechainicio.add("1");
                        fechafin.add("1");
                        horainicio.add("1");
                        horafin.add("1");
                        formulariolleno.add(0);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Agregado a carrito'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
