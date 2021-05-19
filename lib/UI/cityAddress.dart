import 'package:flutter/material.dart';
import 'package:lease_drones/UI/home.dart';

class cityAddress extends StatefulWidget {
  cityAddress();
  @override
  _cityAddressState createState() => _cityAddressState();
}

class _cityAddressState extends State<cityAddress> {
  final cvc = new TextEditingController();
  final fe = new TextEditingController();
  final nt = new TextEditingController();
  String hin = "Seleccione tipo de tarjeta";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      theme: ThemeData(primaryColor: Colors.blue),
      title: 'Flutterwave',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home())),
          ),
          title: Text("Metodos de pago"),
          centerTitle: true,
        ),
        body: Center(
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Pago con tarjeta",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  new DropdownButton<String>(
                    hint: Text(hin),
                    items: <String>['Credito', 'Débito'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        hin = value.toString();
                      });
                    },
                  ),
                  TextField(
                      cursorColor: Colors.white,
                      controller: nt,
                      maxLength: 16,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Número de tarjeta",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Número de tarjeta",
                        hintStyle: TextStyle(color: Colors.black),
                      )),
                  TextField(
                      cursorColor: Colors.white,
                      controller: cvc,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "CVC",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "CVC",
                        hintStyle: TextStyle(color: Colors.black),
                      )),
                  TextField(
                      cursorColor: Colors.white,
                      controller: fe,
                      maxLength: 10,
                      keyboardType: TextInputType.datetime,
                      decoration: new InputDecoration(
                        labelText: "Fecha de expiración",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Fecha de expiración",
                        hintStyle: TextStyle(color: Colors.black),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancelar",
                            style: TextStyle(fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Aceptar",
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
