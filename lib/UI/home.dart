import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/Carrito.dart';
import 'package:lease_drones/UI/categories.dart';
import 'package:lease_drones/UI/categoryCard.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/ofertCard.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

List<Ofert> carrito = <Ofert>[];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  int precio1;
  var rng = new Random();
  var rng2 = new Random();
  int precio2;
  List<Ofert> ofersList = <Ofert>[];
  List<Ofert> nofersList = <Ofert>[];
  List<Category> cat = <Category>[];
  void initState() {
    getArticlesa(context);
    getCategoriesa(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ofersList == null || ofersList.length == 0) {
      return Container();
    }
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
          drawer: NavDrawer(),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Oferta relampago",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Icon(Icons.flash_on, color: Colors.yellow)
                      ],
                    ),
                  ),
                  CardOfert(ofersList[rng2.nextInt(ofersList.length - 1)]),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.list),
                              label: Text("Catalogo de productos")),
                          ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.category),
                              label: Text("Categorías")),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.construction_outlined),
                              label: Text("Panel de control")),
                          ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.person),
                              label: Text("Perfil")),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.receipt_long_outlined),
                              label: Text("Mis rentas")),
                          ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.message),
                              label: Text("Mensajeria")),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Artículo recomendado",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Icon(Icons.recommend, color: Colors.yellow)
                      ],
                    ),
                  ),
                  CardOfert(nofersList[rng.nextInt(nofersList.length - 1)]),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Es hora de la cuponmania!!, redime descuentos en tus articulos favoritos introduciendo los codigos promocionales, para reclamarlos presiona en el botón de la cuponmania.",
                          style: TextStyle(color: Colors.black, fontSize: 19),
                          textAlign: TextAlign.justify,
                        ),
                        ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple),
                            icon: Icon(Icons.countertops_outlined),
                            label: Text("Cupónmania!")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getArticlesa(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getArticles(context, shar.token).then((artic) {
      setState(() {
        nofersList = artic;
        for (var i = 0; i < artic.length; i++) {
          if (artic[i].dto != "0") {
            ofersList.add(artic[i]);
          }
        }
      });
    }).catchError((error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }

  Widget _list() {
    return cat.length > 1
        ? ListView.builder(
            itemCount: cat.length,
            shrinkWrap: true,
            //scrollDirection: Axis.horizontal,
            itemBuilder: (context, posicion) {
              return Container(
                color: Colors.white10,
                alignment: AlignmentDirectional.centerStart,
                child: categoryCard(cat[posicion]),
              );
            })
        : Text("");
  }

  Future<void> getCategoriesa(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getCategories(context, shar.token).then((categ) {
      setState(() {
        cat = categ;
      });
    }).catchError((error) {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}
