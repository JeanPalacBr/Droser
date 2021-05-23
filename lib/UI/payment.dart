import 'package:flutter/material.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/payCardDialog.dart';
import 'package:lease_drones/UI/payTransferDialog.dart';

class Pay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      theme: ThemeData(primaryColor: Colors.blue),
      title: 'Droser',
      debugShowCheckedModeBanner: false,
      home: Payment(),
    );
  }
}

class Payment extends StatefulWidget {
  Payment();
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PayCardDialog();
                        },
                      );
                    },
                    child: Card(
                      color: Colors.blue,
                      elevation: 15,
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "pagar con tarjeta",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.payment,
                                color: Colors.black,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 10.0, right: 10),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PayTransferDialog();
                        },
                      );
                    },
                    child: Card(
                      color: Colors.blue,
                      elevation: 15,
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "pagar con transferencia \nelectrónica",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.money,
                                  color: Colors.black,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
