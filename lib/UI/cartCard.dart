import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/cart.dart';

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
  bool b2 = false;
  bool b3 = false;
  bool b4 = false;
  bool b2c = false;
  bool b3c = false;
  bool b4c = false;
  var fechainiciosub = DateTime.now();
  var fechafinsub = DateTime.now();
  var diffRenta = 1;
  String txcant = "";
  CarritoCardState(this.articulo, this.posx);
  @override
  void initState() {
    super.initState();
    _timeString = DateTime.now().toString();
    _dateString = DateTime.now().toLocal().toString();
    _timefinString = DateTime.now().toString();
    _datefinString = DateTime.now().toLocal().toString();

    final fechainiciosub = DateTime(
        int.tryParse("2021"),
        int.tryParse("01"),
        int.tryParse("01"),
        int.tryParse("03"),
        int.tryParse("03"),
        int.tryParse("00"));
    final fechafinsub = DateTime(
        int.tryParse("2021"),
        int.tryParse("01"),
        int.tryParse("01"),
        int.tryParse("03"),
        int.tryParse("03"),
        int.tryParse("00"));

    sbtotal(
        double.tryParse((double.parse(articulo.precio.toString()) *
                ((100 - double.tryParse(articulo.dto.toString())) / 100))
            .toString()),
        int.parse("1"));
    subtotales[posx] = subtotal;
    cantidades[posx] = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
          color: articulo.disponible == "" || articulo.disponible == null
              ? articulo.formulario
                  ? Colors.blue[300]
                  : Colors.orange[400]
              : Colors.red[400],
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(articulo.nombre,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Categor??a: " + articulo.categoria,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                          Text(
                              "Precio: \$" +
                                  (double.parse(articulo.precio.toString()) *
                                          ((100 -
                                                  double.tryParse(articulo.dto
                                                      .toString())) /
                                              100))
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                          Text("Subtotal: \$" + subtotal.toStringAsFixed(2),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                          articulo.categoria != "piloto"
                              ? Row(
                                  children: <Widget>[
                                    Text("Ingrese la cantidad: ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0)),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 30,
                                            width: 60,
                                            child: TextField(
                                              cursorColor: Colors.white,
                                              keyboardType:
                                                  TextInputType.number,
                                              showCursor: true,
                                              onChanged: (text) {
                                                setState(() {
                                                  if (text != null) {
                                                    txcant = text;
                                                    sbtotal(
                                                        double.tryParse((double
                                                                    .parse(articulo
                                                                        .precio
                                                                        .toString()) *
                                                                ((100 -
                                                                        double.tryParse(articulo
                                                                            .dto
                                                                            .toString())) /
                                                                    100))
                                                            .toString()),
                                                        int.parse(text));
                                                    subtotales[posx] = subtotal;
                                                    cantidades[posx] = text;
                                                  }
                                                  if (text == null) {
                                                    sbtotal(
                                                        double.tryParse(articulo
                                                            .precio
                                                            .toString()),
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
                                                      borderSide:
                                                          new BorderSide(
                                                              color: Colors
                                                                  .white))),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: articulo.image == null
                              ? Image.network(
                                  "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                                  width: 109,
                                  alignment: Alignment.center,
                                )
                              : Image(
                                  image: articulo.image,
                                  width: 109,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 3),
                Padding(
                  padding: const EdgeInsets.only(right: 2, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                            "Seleccione la fecha y hora de inicio y finalizaci??n de la renta.",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                      Row(children: [
                        Text("Fecha inicio:",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                        TextButton(
                          onPressed: () async {
                            var selectedTimes = await showDatePicker(
                              locale: Locale("es", "ES"),
                              helpText:
                                  "Seleccione la fecha de inicio de la renta",
                              context: context,
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 60)),
                            );
                            if (selectedTimes != null) {
                              var selectedDateTime = DateTime(
                                selectedTimes.year,
                                selectedTimes.month,
                                selectedTimes.day,
                              );
                              _date = selectedDateTime;
                              setState(() {
                                formulariolleno[posx]++;
                                b2 = true;
                                b2c = false;
                                _dateString = selectedTimes.toString();
                                fechainicio[posx] = _dateString;
                              });
                            }
                          },
                          child: Text(
                              _dateString.length > 6
                                  ? _dateString.substring(0, 10)
                                  : _dateString,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                        ),
                      ]),
                      Row(
                        children: [
                          Text("Hora inicio:",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                          TextButton(
                            onLongPress: b2 == false
                                ? null
                                : () {
                                    setState(() {
                                      b2c = true;
                                    });
                                  },
                            onPressed: b2 == false
                                ? () {
                                    setState(() {
                                      b2c = true;
                                    });
                                  }
                                : () async {
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
                                        formulariolleno[posx]++;
                                        b3 = true;
                                        b3c = false;
                                        _timeString = selectedTime.toString();
                                        horainicio[posx] = _timeString;
                                        fechainiciosub = DateTime(
                                            int.tryParse(
                                                _dateString.substring(0, 4)),
                                            int.tryParse(
                                                _dateString.substring(5, 7)),
                                            int.tryParse(
                                                _dateString.substring(8, 10)),
                                            int.tryParse(
                                                _timeString.substring(10, 12)),
                                            int.tryParse(
                                                _timeString.substring(13, 15)),
                                            int.tryParse("00"));
                                      });
                                    }
                                  },
                            child: Text(
                                _timeString.length > 6
                                    ? _timeString.substring(10, 15)
                                    : _timeString,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          ),
                        ],
                      ),
                      b2c
                          ? Text(
                              "*Seleccione la fecha de inicio",
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Divider(thickness: 3),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text("Fecha fin:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                            TextButton(
                              onPressed: b3 == false
                                  ? () {
                                      setState(() {
                                        b3c = true;
                                      });
                                    }
                                  : () async {
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
                                        var selectedDateTime = DateTime(
                                          selectedTimes.year,
                                          selectedTimes.month,
                                          selectedTimes.day,
                                        );
                                        _date = selectedDateTime;
                                        setState(() {
                                          formulariolleno[posx]++;
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
                                      color: Colors.white, fontSize: 25)),
                            ),
                          ]),
                          b3c
                              ? Text(
                                  "*Seleccione la hora de inicio",
                                  style: TextStyle(color: Colors.red),
                                )
                              : Container(),
                          Row(
                            children: [
                              Text("Hora fin:",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                              TextButton(
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
                                      formulariolleno[posx]++;
                                      _timefinString = selectedTime.toString();
                                      horafin[posx] = _timefinString;
                                      fechafinsub = DateTime(
                                          int.tryParse(
                                              _datefinString.substring(0, 4)),
                                          int.tryParse(
                                              _datefinString.substring(5, 7)),
                                          int.tryParse(
                                              _datefinString.substring(8, 10)),
                                          int.tryParse(
                                              _timefinString.substring(10, 12)),
                                          int.tryParse(
                                              _timefinString.substring(13, 15)),
                                          int.tryParse("00"));
                                      diffRenta = fechafinsub
                                          .difference(fechainiciosub)
                                          .inHours;
                                      sbtotal(
                                          double.tryParse((double.parse(articulo
                                                      .precio
                                                      .toString()) *
                                                  ((100 -
                                                          double.tryParse(
                                                              articulo.dto
                                                                  .toString())) /
                                                      100))
                                              .toString()),
                                          int.parse(txcant));
                                      subtotales[posx] = subtotal;
                                    });
                                  }
                                },
                                child: Text(
                                    _timefinString.length > 6
                                        ? _timefinString.substring(10, 15)
                                        : _timefinString,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
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
          )),
    );
  }

  void sbtotal(double precio, int cantidad) {
    subtotal = precio * cantidad * diffRenta;
  }

  void sumatoria() {
    for (var i = 0; i < subtotales.length; i++) {
      apagar = apagar + subtotales[i];
    }
  }
}
