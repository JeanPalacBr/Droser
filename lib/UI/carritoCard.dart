import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/Carrito.dart';

class CarritoCard extends StatefulWidget {
  final Ofert articulo;
  final int posx;
  CarritoCard(this.articulo, this.posx);
  @override
  CarritoCardState createState() => CarritoCardState(this.articulo, this.posx);
}

class CarritoCardState extends State<CarritoCard> {
  final Ofert articulo;
  final cantidade = TextEditingController();
  double subtotal = 0;
  int posx;
  DateTime _date;
  DateTime _time;
  String _timeString = "HH:MM";
  String _timefinString = "HH:MM";
  String _dateString = "AAAA-MM-DD";
  String _datefinString = "AAAA-MM-DD";
  CarritoCardState(this.articulo, this.posx);
  @override
  void initState() {
    super.initState();
    _timeString = DateTime.now().toString();
    _dateString = DateTime.now().toLocal().toString();

    subtotales.add(0);
    cantidades.add("1");
    fechainicio.add("1");
    fechafin.add("1");
    horainicio.add("1");
    horafin.add("1");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blue[400],
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(articulo.nombre,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text("Categoría: " + articulo.categoria,
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                      Text(
                          "Precio: \$" +
                              (double.parse(articulo.precio.toString()) *
                                      ((100 -
                                              double.tryParse(
                                                  articulo.dto.toString())) /
                                          100))
                                  .toString(),
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                      Text("Subtotal: \$" + subtotal.toStringAsFixed(2),
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                      Row(
                        children: <Widget>[
                          Text("Ingrese la cantidad: ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                          Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                  width: 60,
                                  child: TextField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    showCursor: true,
                                    onChanged: (text) {
                                      setState(() {
                                        if (text != null) {
                                          sbtotal(
                                              double.tryParse((double.parse(
                                                          articulo.precio
                                                              .toString()) *
                                                      ((100 -
                                                              double.tryParse(
                                                                  articulo.dto
                                                                      .toString())) /
                                                          100))
                                                  .toString()),
                                              int.parse(text));
                                          subtotales[posx] = subtotal;
                                          cantidades[posx] = text;
                                        }
                                        if (text == null) {
                                          sbtotal(
                                              double.tryParse(
                                                  articulo.precio.toString()),
                                              0);
                                          subtotales[posx] = subtotal;
                                          cantidades[posx] = text;
                                        }
                                      });
                                    },
                                    controller: cantidade,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white))),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 2, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                      "Seleccione la fecha y hora de \ninicio y finalización de la renta.",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
                                ),
                                Row(children: [
                                  Text("Fecha inicio:",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
                                  FlatButton(
                                    onPressed: () async {
                                      var selectedTimes = await showDatePicker(
                                        locale: Locale("es", "ES"),
                                        helpText:
                                            "Seleccione la fecha de inicio de la renta",
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 60)),
                                      );
                                      if (selectedTimes != null) {
                                        final now = DateTime.now();
                                        var selectedDateTime = DateTime(
                                          selectedTimes.year,
                                          selectedTimes.month,
                                          selectedTimes.day,
                                        );
                                        _date = selectedDateTime;
                                        setState(() {
                                          _dateString =
                                              selectedTimes.toString();
                                          fechainicio[posx] = _dateString;
                                        });
                                      }
                                    },
                                    child: Text(
                                        _dateString.length > 6
                                            ? _dateString.substring(0, 10)
                                            : _dateString,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25)),
                                  ),
                                ]),
                                Row(
                                  children: [
                                    Text("Hora inicio:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0)),
                                    FlatButton(
                                      onPressed: () async {
                                        var selectedTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (selectedTime != null) {
                                          final now = DateTime.now();
                                          var selectedDateTime = DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              selectedTime.hour,
                                              selectedTime.minute);
                                          _time = selectedDateTime;
                                          setState(() {
                                            _timeString =
                                                selectedTime.toString();
                                            horainicio[posx] = _timeString;
                                          });
                                        }
                                      },
                                      child: Text(
                                          _timeString.length > 6
                                              ? _timeString.substring(10, 15)
                                              : _timeString,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 2, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children: [
                                  Text("Fecha fin:",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
                                  FlatButton(
                                    onPressed: () async {
                                      var selectedTimes = await showDatePicker(
                                        locale: Locale("es", "ES"),
                                        helpText:
                                            "Seleccione la fecha de fin de la renta",
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 60)),
                                      );
                                      if (selectedTimes != null) {
                                        final now = DateTime.now();
                                        var selectedDateTime = DateTime(
                                          selectedTimes.year,
                                          selectedTimes.month,
                                          selectedTimes.day,
                                        );
                                        _date = selectedDateTime;
                                        setState(() {
                                          _datefinString =
                                              selectedTimes.toString();
                                          fechafin[posx] = _datefinString;
                                        });
                                      }
                                    },
                                    child: Text(
                                        _datefinString.length > 6
                                            ? _datefinString.substring(0, 10)
                                            : _datefinString,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25)),
                                  ),
                                ]),
                                Row(
                                  children: [
                                    Text("Hora fin:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0)),
                                    FlatButton(
                                      onPressed: () async {
                                        var selectedTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (selectedTime != null) {
                                          final now = DateTime.now();
                                          var selectedDateTime = DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              selectedTime.hour,
                                              selectedTime.minute);
                                          _time = selectedDateTime;
                                          setState(() {
                                            _timefinString =
                                                selectedTime.toString();
                                            horafin[posx] = _timefinString;
                                          });
                                        }
                                      },
                                      child: Text(
                                          _timefinString.length > 6
                                              ? _timefinString.substring(10, 15)
                                              : _timefinString,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    // right: 15,
                  ),
                  child: Image.network(
                    "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                    width: 100,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ],
        )));
  }

  void sbtotal(double precio, int cantidad) {
    subtotal = precio * cantidad;
  }

  void sumatoria() {
    for (var i = 0; i < subtotales.length; i++) {
      apagar = apagar + subtotales[i];
    }
  }
}
