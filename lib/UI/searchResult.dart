import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/ofertCard.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:flutter/widgets.dart';

class SearchResult extends StatefulWidget {
  String busqued;
  SearchResult(this.busqued);
  @override
  SearchResultState createState() => SearchResultState(this.busqued);
}

class SearchResultState extends State<SearchResult> {
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  String busqued;
  List<Ofert> ofersList = <Ofert>[];
  List<ImageProvider<Object>> img = <ImageProvider<Object>>[];
  SearchResultState(this.busqued);
  @override
  void initState() {
    getArticlesa(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    return ofersList.length > 0
        ? ListView.builder(
            itemCount: ofersList.length,
            itemBuilder: (context, posicion) {
              return Container(
                color: Colors.white10,
                alignment: AlignmentDirectional.centerStart,
                child: CardOfert(ofersList[posicion]),
              );
            })
        : Column(
            children: [
              Text("No se encontraron resultados de su busqueda"),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new CircularProgressIndicator(
                    backgroundColor: Colors.white),
              )
            ],
          );
  }

  Future<void> getArticlesa(BuildContext context) async {
    searchByName(busqued).then((artic) {
      ofersList = artic;
      for (var v = 0; v < artic.length; v++) {
        if (artic[v].imagen != null) {
          print(v);
          searchImage(artic[v].imagen).then((aim) {
            setState(() {
              ofersList[v].image = aim;
            });
          });
        }
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error" + error.toString()),
        duration: Duration(seconds: 5),
      ));
    });
  }
}
