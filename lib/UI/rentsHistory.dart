import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/listTileRents.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/rentCard.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

class RentsHistory extends StatefulWidget {
  RentsHistory();
  @override
  RentsHistoryState createState() => RentsHistoryState();
}

class RentsHistoryState extends State<RentsHistory> {
  List<Rented> rentsList = <Rented>[];
  RentsHistoryState();
  @override
  void initState() {
    getRented(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.white, Colors.blue[200], Colors.blue[400]],
          stops: [0.1, 0.3, 0.7],
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Droser"),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: NavDrawer(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: _list()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return rentsList.length > 0
        ? ListView.builder(
            itemCount: rentsList.length,
            itemBuilder: (context, posicion) {
              return Container(
                color: Colors.white10,
                alignment: AlignmentDirectional.centerStart,
                child: ListTileRents(rentsList[posicion]),
              );
              //Icon(Icons.delete, color: Colors.white)),
            })
        : Text("No se encontraron rentas");
  }

  Future<void> getRented(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    userRentsList(shar.userid).then((artic) {
      setState(() {
        rentsList = artic;
      });
    }).catchError((error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}
