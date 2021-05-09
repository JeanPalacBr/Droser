import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/ofertCard.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Ofert> ofersList = <Ofert>[];
  @override
  void initState() {
    getArticlesa(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Droser"), backgroundColor: Colors.indigo[700]),
      drawer: NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _list()),
          ],
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
    getArticles(context, shar.token).then((artic) {
      setState(() {
        ofersList = artic;
      });
    }).catchError((error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}
