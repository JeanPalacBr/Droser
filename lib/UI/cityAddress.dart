import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/receipt.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';
import 'package:lease_drones/Services/APIcon.dart';

class CityAddress extends StatefulWidget {
  String cuponazo = "";
  CityAddress(this.cuponazo);
  @override
  _CityAddressState createState() => _CityAddressState(this.cuponazo);
}

class _CityAddressState extends State<CityAddress> {
  final dir = new TextEditingController();
  String hin = "Seleccione tipo de tarjeta";
  Coupon valid = new Coupon();
  String cupval = "0";
  String cuponazo = "";
  String res = "";
  bool lleno = false;
  List<City> citiesL = <City>[];
  String ciudad = "Seleccione su ciudad";
  String selciuda = "Seleccione su ciudad";
  @override
  void initState() {
    _loadCities();
    super.initState();
  }

  _CityAddressState(this.cuponazo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      theme: ThemeData(primaryColor: Colors.blue),
      title: 'Droser',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home())),
          ),
          title: Text("Envío"),
          centerTitle: true,
        ),
        body: Center(
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Opciones de envío",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: containerText(
                        DropdownButtonHideUnderline(
                            child: new DropdownButton<String>(
                          hint: new Text(selciuda),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              ciudad = newValue;
                            });
                            print(ciudad);
                          },
                          items: citiesL.map((data) {
                            return DropdownMenuItem(
                              value: data.idciudad.toString(),
                              onTap: () {
                                selciuda = data.nombre;
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  data.nombre,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )),
                      ),
                    ),
                    containerText(Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          cursorColor: Colors.white,
                          controller: dir,
                          keyboardType: TextInputType.streetAddress,
                          decoration: new InputDecoration(
                            labelText: "Dirección",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Dirección",
                            hintStyle: TextStyle(color: Colors.black),
                          )),
                    )),
                    lleno
                        ? Text(
                            "*Por favor, llene todos los campos",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    ElevatedButton.icon(
                      icon: Icon(Icons.monetization_on_outlined),
                      label: Text(
                        "Ir a pagar",
                        style: TextStyle(color: Colors.white),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                      onPressed: () {
                        if (selciuda != "Seleccione su ciudad" ||
                            ciudad != "Seleccione su ciudad" ||
                            dir.value.text.isNotEmpty) {
                          lleno = false;
                          publicadosa.clear();
                          disponibles.clear();
                          nodisponibles.clear();
                          if (invited == false) {
                            SharedPrefs shar = new SharedPrefs();
                            for (var i = 0; i < subtotales.length; i++) {
                              if (subtotales[i] == 0.0) {
                                subtotales.removeAt(i);
                              }
                            }

                            verifyCoupon(cuponazo).then((cup) {
                              if (cup != null) {
                                valid = cup;
                                if (valid.idcupon != null ||
                                    valid.nombre != "no" ||
                                    valid.idcupon != "0000") {
                                  cupval = valid.idcupon;
                                  double mayor = 0;
                                  int gi = 0;
                                  for (var i = 0; i < subtotales.length; i++) {
                                    if (subtotales[i] > mayor) {
                                      mayor = subtotales[i];
                                      gi = i;
                                    }
                                  }
                                  subtotales[gi] = subtotales[gi] *
                                      ((100 - double.tryParse(valid.dcto)) /
                                          100);
                                }
                                for (var i = 0; i < carrito.length; i++) {
                                  Rent articulo = new Rent(
                                      idarticulo: carrito[i].idarticulo,
                                      cantidad: int.tryParse(cantidades[i]),
                                      direccionEntrega: dir.value.text,
                                      fechaInicio:
                                          fechainicio[i].substring(0, 10),
                                      fechaFin: fechafin[i].substring(0, 10),
                                      horaInicio:
                                          horainicio[i].substring(10, 15) +
                                              ":00",
                                      horaFin:
                                          horafin[i].substring(10, 15) + ":00",
                                      idciudad: ciudad,
                                      idcupon: cupval.toString(),
                                      idusuario: shar.userid,
                                      valor: subtotales[i]);
                                  setState(() {
                                    publicadosa.add(articulo);
                                  });
                                  availability(articulo, shar.token)
                                      .then((cup) {
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
                                      if (disponibles.length ==
                                          carrito.length) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Receipt(disponibles)));
                                      } else {
                                        if (nodisponibles.length > 0) {
                                          for (var i = 0;
                                              i < carrito.length;
                                              i++) {
                                            for (var j = 0;
                                                j < nodisponibles.length;
                                                j++) {
                                              if (carrito[i].idarticulo ==
                                                  nodisponibles[j].idarticulo) {
                                                setState(() {
                                                  carrito[i].disponible =
                                                      "No disponible";
                                                });
                                              }
                                            }
                                          }
                                          _showMyDialog(context);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Carrito(carrito)),
                                            (Route<dynamic> route) => false,
                                          );
                                        }
                                      }
                                    }
                                  });
                                }
                              }
                            });
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                              (Route<dynamic> route) => false,
                            );
                          }
                        } else {
                          setState(() {
                            lleno = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loadCities() {
    getCities(context).then((cities) {
      setState(() {
        citiesL = cities;
      });
    });
  }

  Widget containerText(Widget widg) {
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo[700], width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: widg,
    );
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text('Articulos no disponibles'),
      content: Text(
          "Se encontraron articulos no disponibles en las fechas o cantidades especificadas, verifique la información e intente nuevamente. los articulos no disponibles han sido señalados con color rojo."),
    );
  }

  Future _showMyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => _buildAlertDialog(),
    );
  }
}
