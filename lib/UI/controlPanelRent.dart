import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class ControlPanelRent extends StatefulWidget {
  Rented ren;
  //= new Rented();
  ControlPanelRent(this.ren);
  @override
  ControlPanelRentstate createState() => ControlPanelRentstate(this.ren);
}

class ControlPanelRentstate extends State<ControlPanelRent> {
  Rented ren = new Rented();
  CountDownController controller = new CountDownController();
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  int diffRenta = 0;
  int diffCon = 0;
  int estado = 0;

  ControlPanelRentstate(this.ren);
  final fechactual = DateTime.now();

  @override
  void initState() {
    final fechainicio = DateTime(
        int.tryParse(ren.fechaInicio.substring(0, 4)),
        int.tryParse(ren.fechaInicio.substring(5, 7)),
        int.tryParse(ren.fechaInicio.substring(8, 10)),
        int.tryParse(ren.horaInicio.substring(0, 2)),
        int.tryParse(ren.horaInicio.substring(3, 5)),
        int.tryParse(ren.horaInicio.substring(6, 8)));
    final fechafin = DateTime(
        int.tryParse(ren.fechaFin.substring(0, 4)),
        int.tryParse(ren.fechaFin.substring(5, 7)),
        int.tryParse(ren.fechaFin.substring(8, 10)),
        int.tryParse(ren.horaFin.substring(0, 2)),
        int.tryParse(ren.horaFin.substring(3, 5)),
        int.tryParse(ren.horaFin.substring(6, 8)));

    if (ren.estado == "2" ||
        fechactual.isAfter(fechainicio) ||
        !fechactual.isAfter(fechafin)) {
      diffRenta = fechafin.difference(fechainicio).inSeconds;
      diffCon = fechactual.difference(fechainicio).inSeconds;
    } else {
      if (ren.estado == "1" || fechainicio.isAfter(fechactual)) {
        final fechactual = DateTime.now();
        final created = DateTime.tryParse(ren.created);
        diffRenta = fechactual.difference(fechainicio).inSeconds;

        diffCon = created.difference(fechactual).inSeconds;
      }
    }
    //diffRenta;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue[400],
          Colors.blue[200],
          Colors.white,
        ], stops: [
          0.45,
          0.3,
          0.3
        ], begin: FractionalOffset.topRight, end: FractionalOffset.bottomLeft)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                      icon:
                          !searching ? Icon(Icons.search) : Icon(Icons.cancel),
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
          drawer: NavDrawer(),
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Center(
                    child: new Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      height: 20.0,
                      width: 80.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(
                      ren.estado == "2"
                          ? "Tiempo transcurrido de renta"
                          : "Tiempo restante para comienzo de renta",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircularCountDownTimer(
                    duration: diffRenta,
                    initialDuration: diffCon,
                    controller: CountDownController(),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    ringColor: Colors.white,
                    ringGradient: null,
                    fillColor: Colors.green[300],
                    fillGradient: null,
                    backgroundColor: Colors.blue[400],
                    backgroundGradient: null,
                    strokeWidth: 30,
                    strokeCap: StrokeCap.round,
                    textStyle: TextStyle(
                        fontSize: 33.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textFormat: CountdownTextFormat.HH_MM_SS,
                    isReverse: true,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: true,
                    onStart: () {
                      print('Countdown Started');
                    },
                    onComplete: () {
                      print('Countdown Ended');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.date_range),
                    Text(
                      "Fecha y hora de creación: \n" + ren.created,
                      style: TextStyle(fontSize: 21),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.category),
                          Text(
                            "Cantidad: " + ren.cantidad.toString(),
                            style: TextStyle(fontSize: 21),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.date_range),
                          Text(
                            "Fecha de inicio: " + ren.fechaInicio,
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.date_range),
                          Text(
                            "Fecha de fin: " + ren.fechaFin,
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.hourglass_bottom),
                          Text(
                            "Hora de inicio: " + ren.horaInicio,
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.hourglass_bottom),
                          Text(
                            "Hora de fin: " + ren.horaFin,
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Text(
                            "Estado: " +
                                (ren.estado == "1"
                                    ? "Pendiente"
                                    : ren.estado == "2"
                                        ? "En curso"
                                        : ren.estado == "3"
                                            ? "Terminado"
                                            : "Cancelado"),
                            style: TextStyle(fontSize: 21),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Center(
                        child: ElevatedButton.icon(
                      icon: Icon(Icons.send),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.green[500]),
                      onPressed: () {
                        FlutterOpenWhatsapp.sendSingleMessage(
                            "+573007482244",
                            "Solicito atención, renta numero: " +
                                ren.idrenta +
                                ", producto numero: " +
                                ren.idarticulo +
                                ", usuario: " +
                                usuario.nombre);
                      },
                      label: Text("Enviar mensaje por Whatsapp"),
                    )),
                    Divider(
                      thickness: 3,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      "Se ha enviado un mensaje urgente a servicio al cliente, nos contactaremos inmediatamente con usted"),
                                  duration: const Duration(seconds: 7),
                                ),
                              );
                            });
                            droserBot("SOLICITO AYUDA URGENTE! \n Nombre:" +
                                usuario.nombre +
                                "\n Telefono:" +
                                usuario.telefono +
                                "\n Renta:" +
                                ren.idrenta +
                                "\n Entregado en: " +
                                ren.direccionEntrega +
                                "\n en: " +
                                usuario.ciudad);
                          },
                          icon: Icon(
                            Icons.adjust,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Botón de pánico",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
