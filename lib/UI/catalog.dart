import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/Carrito.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/ofertCard.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

import 'searchResult.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Ofert> ofersList = <Ofert>[];
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
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
            title: !searching
                ? Text("Droser")
                : TextField(
                    controller: busqueda,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        hintText: "Busca drones, articulos y más...",
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
