import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/ofertCard.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

class SearchByCategory extends StatefulWidget {
  String idcat;
  SearchByCategory(this.idcat);
  @override
  SearchByCategoryState createState() => SearchByCategoryState(this.idcat);
}

class SearchByCategoryState extends State<SearchByCategory> {
  List<Ofert> ofersList = <Ofert>[];
  String idcat;
  SearchByCategoryState(this.idcat);
  @override
  void initState() {
    getArticlesa(context);
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
    return ListView.builder(
        itemCount: ofersList.length,
        itemBuilder: (context, posicion) {
          return Container(
            color: Colors.white10,
            alignment: AlignmentDirectional.centerStart,
            child: CardOfert(ofersList[posicion]),
          );
          //Icon(Icons.delete, color: Colors.white)),
        });
  }

  Future<void> getArticlesa(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    searchByCategory(idcat).then((artic) {
      setState(() {
        ofersList = artic;
      });
    }).catchError((error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}
