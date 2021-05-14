import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/carritoCard.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/receipt.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';
import 'navDrawer.dart';

List<double> subtotales = <double>[];
List<String> cantidades = <String>[];
List<String> fechainicio = <String>[];
List<String> fechafin = <String>[];
List<String> horainicio = <String>[];
List<String> horafin = <String>[];
List<Rent> publicadosa = <Rent>[];
List<Rent> disponibles = <Rent>[];
List<Rent> nodisponibles = <Rent>[];
double apagar;

class Carrito extends StatefulWidget {
  final List<Ofert> carri;
  Carrito(this.carri);
  @override
  _CarritoState createState() => _CarritoState(this.carri);
}

class _CarritoState extends State<Carrito> {
  List<Ofert> carri = <Ofert>[];
  final cupon = TextEditingController();
  Coupon valid = new Coupon();
  int cupval = 0;
  String res = "";
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  void initState() {
    super.initState();
  }

  _CarritoState(this.carri);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('es')],
      home: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: !searching
              ? Text("Droser")
              : TextField(
                  controller: busqueda,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: "Busca drones, articulos y más...",
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white),
                  onSubmitted: (busqueda) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchResult(busqueda)));
                  },
                ),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                    icon: !searching ? Icon(Icons.search) : Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.searching = !this.searching;
                        busqueda.clear();
                      });
                    }),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Carrito(carrito)));
                  },
                  icon: Icon(Icons.shopping_cart),
                )
              ],
            )
          ],
          backgroundColor: Colors.blue[400],
          elevation: 0,
        ),
        body: Builder(
          builder: (context) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                      icon: Icon(Icons.remove_shopping_cart),
                      label: Text("Limpiar carrito"),
                      onPressed: () {
                        setState(() {
                          carri.clear();
                          subtotales.clear();
                          cantidades.clear();
                          fechainicio.clear();
                          fechafin.clear();
                          horainicio.clear();
                          horafin.clear();
                          subtotales.clear();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('El carrito ha sido limpiado'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  Text("Redimir cupón: "),
                  Flexible(
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: cupon,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(child: _listArticulos()),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.monetization_on_outlined),
                  label: Text(
                    "Ir a pagar",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                  onPressed: () {
                    disponibles.clear();
                    nodisponibles.clear();

                    // try{
                    SharedPrefs shar = new SharedPrefs();
                    for (var i = 0; i < subtotales.length; i++) {
                      if (subtotales[i] == 0.0) {
                        subtotales.removeAt(i);
                      }
                    }

                    verifyCoupon(cupon.value.text).then((cup) {
                      if (cup != null) {
                        valid = cup;
                        if (valid.idcupon != null ||
                            valid.nombre == "no" ||
                            valid.idcupon == 0000) {
                          cupval = valid.idcupon;
                          double mayor = 0;
                          int gi = 0;
                          for (var i = 0; i < subtotales.length; i++) {
                            if (subtotales[i] > mayor) {
                              mayor = subtotales[i];
                              gi = i;
                            }
                          }
                          subtotales[gi] =
                              subtotales[gi] * ((100 - valid.dcto) / 100);
                        }
                        for (var i = 0; i < carri.length; i++) {
                          Rent articulo = new Rent(
                              idarticulo: carri[i].idarticulo,
                              cantidad: int.tryParse(cantidades[i]),
                              direccionEntrega: usuario.direccion,
                              fechaInicio: fechainicio[i].substring(0, 10),
                              fechaFin: fechafin[i].substring(0, 10),
                              horaInicio:
                                  horainicio[i].substring(10, 15) + ":00",
                              horaFin: horafin[i].substring(10, 15) + ":00",
                              idciudad: usuario.ciudad,
                              idcupon: cupval.toString(),
                              idusuario: shar.userid,
                              valor: subtotales[i]);
                          setState(() {
                            publicadosa.add(articulo);
                          });
                          availability(articulo).then((cup) {
                            if (cup != null) {
                              res = cup;
                            }
                            if (res != "" || res == null) {
                              if (res == "Disponible") {
                                disponibles.add(articulo);
                              } else {
                                if (res != null) {
                                  nodisponibles.add(articulo);
                                }
                              }
                              if (disponibles.length == carrito.length) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Receipt(disponibles)));
                              } else {
                                if (nodisponibles.length > 0) {
                                  for (var i = 0; i < carrito.length; i++) {
                                    for (var j = 0;
                                        j < nodisponibles.length;
                                        j++) {
                                      if (carrito[i].idarticulo ==
                                          nodisponibles[j].idarticulo) {
                                        carrito[i].disponible = "No disponible";
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          });
                        }
                      }
                    });

                    // }catch(e){}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> verificarcupon(String cupon) async {
  //   verifyCoupon(cupon).then((cup) {
  //     if (cup != null) {
  //       valid = cup;
  //     }
  //   });
  // }

  // Future<void> disponibilidad(Rent r) async {
  //   availability(r).then((cup) {
  //     if (cup != null) {
  //       res = cup;
  //     }
  //   });
  // }

  void sumatoria() {
    for (var i = 0; i < subtotales.length; i++) {
      apagar = apagar + subtotales[i];
    }
  }

  Widget _listArticulos() {
    return carri.length >= 1
        ? ListView.builder(
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
          )
        : Text("No se encontraron articulos en el carrito");
  }
}
