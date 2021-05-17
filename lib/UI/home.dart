import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/Catalog.dart';
import 'package:lease_drones/UI/categories.dart';
import 'package:lease_drones/UI/categoryCard.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/ofertCard.dart';
import 'package:lease_drones/UI/profile.dart';
import 'package:lease_drones/UI/rentsActive.dart';
import 'package:lease_drones/UI/rentsHistory.dart';
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
    setState(() {
      getArticlesa(context);
    });

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
          drawer: NavDrawer(),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Oferta relámpago",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Icon(Icons.flash_on, color: Colors.yellow)
                    ],
                  ),
                  ofersList.length != 0 ? CardOfert(ofersList[0]) : Container(),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Catalog()));
                                },
                                icon: Icon(
                                  Icons.list,
                                  color: Colors.black,
                                ),
                                label: Text("Catálogo de artículos",
                                    style: TextStyle(color: Colors.black))),
                            if (invited == false) ...{
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfile()));
                                  },
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  label: Text("Perfil de usuario",
                                      style: TextStyle(color: Colors.black))),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RentsActive()));
                                  },
                                  icon: Icon(
                                    Icons.construction_outlined,
                                    color: Colors.black,
                                  ),
                                  label: Text("Panel de control",
                                      style: TextStyle(color: Colors.black))),
                            }
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Categories()));
                                },
                                icon: Icon(
                                  Icons.category,
                                  color: Colors.black,
                                ),
                                label: Text("Categorías",
                                    style: TextStyle(color: Colors.black))),
                            if (invited == false) ...{
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RentsHistory()));
                                  },
                                  icon: Icon(
                                    Icons.receipt_long_outlined,
                                    color: Colors.black,
                                  ),
                                  label: Text("Mis rentas",
                                      style: TextStyle(color: Colors.black))),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.message,
                                    color: Colors.black,
                                  ),
                                  label: Text("Mensajería",
                                      style: TextStyle(color: Colors.black))),
                            }
                          ],
                        ),
                      ],
                    ),
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
                        Icon(Icons.recommend, color: Colors.white)
                      ],
                    ),
                  ),
                  nofersList.length != 0
                      ? CardOfert(nofersList[0])
                      : Container(),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  if (invited == false) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Es hora de la cuponmanía!!, redime descuentos en tus artículos favoritos introduciendo los códigos promocionales, para reclamarlos presiona en el botón de la cuponmanía.",
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            textAlign: TextAlign.justify,
                          ),
                          ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.purple),
                              icon: Icon(Icons.countertops_outlined),
                              label: Text("Cuponmanía!")),
                        ],
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getArticlesa(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    try {
      getArticles(context, shar.token).then((artic) {
        if (artic != null || artic.length > 0) {
          setState(() {
            //nofersList = artic;
            for (var i = 0; i < artic.length; i++) {
              if (artic[i].dto != "0") {
                ofersList.add(artic[i]);
              } else {
                nofersList.add(artic[i]);
              }
            }
          });
        }
      }).catchError((error) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
      });
    } catch (e) {}
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
