import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/cartCard.dart';
import 'package:lease_drones/UI/cityaddress.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/searchResult.dart';
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
List<int> formulariolleno = <int>[];

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
  String cupval = "0";
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
      debugShowCheckedModeBanner: false,
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
                      hintText: "Busca drones, artículos y más...",
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
                          formulariolleno.clear();
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
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.monetization_on_outlined),
                  label: Text(
                    "Ir a pagar",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.indigo[700]),
                  onPressed: () {
                    int badformulario = 0;
                    for (var i = 0; i < formulariolleno.length; i++) {
                      if (formulariolleno[i] == 4 ||
                          formulariolleno[i] % 4 == 0) {
                        carri[i].formulario = true;
                      } else {
                        carri[i].formulario = false;
                        formulariolleno[i] = 0;
                        badformulario = 1;
                      }
                    }

                    if (badformulario != 1) {
                      publicadosa.clear();
                      disponibles.clear();
                      nodisponibles.clear();
                      if (invited == false) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CityAddress(cupon.value.text)));
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    } else {
                      _showMyDialog(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Carrito(carrito)),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sumatoria() {
    for (var i = 0; i < subtotales.length; i++) {
      apagar = apagar + subtotales[i];
    }
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text('Fechas u horas no seleccionadas'),
      content: Text(
          "Se encontraron articulos con fechas u horas no especificadas, verifique la información e intente nuevamente. los articulos en cuestión han sido señalados con color naranja."),
    );
  }

  Future _showMyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => _buildAlertDialog(),
    );
  }

  Widget _listArticulos() {
    return carri.length >= 1
        ? ListView.builder(
            itemCount: carri.length,
            itemBuilder: (context, posicion) {
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
                    subtotales.removeAt(posicion);
                    cantidades.removeAt(posicion);
                  });
                },
              );
            },
          )
        : Text("No se encontraron artículos en el carrito");
  }
}
