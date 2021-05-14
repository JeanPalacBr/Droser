import 'package:flutter/material.dart';
import 'package:lease_drones/UI/payDialog.dart';

class Pay extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      theme: ThemeData(primaryColor: Colors.blue),
      title: 'Flutterwave',
      debugShowCheckedModeBanner: false,
      home: Payment(title: 'Metodos de pago'),
    );
  }
}

class Payment extends StatefulWidget {
  Payment({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                          return CustomDialogBox(
                            title: "Custom Dialog Demo",
                            descriptions:
                                "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                            text: "Yes",
                          );
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
                    onTap: () {},
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
                                "pagar con transferencia electrónica",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
