import 'package:flutter/material.dart';
import 'package:lease_drones/UI/detailOfert.dart';
import 'package:lease_drones/UI/navDrawer.dart';

//List<ArticulosInfoAPI> carrito = <ArticulosInfoAPI>[];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

TextEditingController busqueda = new TextEditingController();

class _HomeState extends State<Home> {
//  List<ArticulosInfoAPI> resbusqueda = new List<ArticulosInfoAPI>();
  //String qery = "https://frutiland.herokuapp.com/search?q=";
  bool searching = false;
  bool encontrado = false;
  int precio1;
  int precio2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          title: !searching
              ? Text("Droser")
              : TextField(
                  decoration: InputDecoration(
                      hintText: "Busca drones, articulos y más...",
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white),
                ),
          actions: <Widget>[
            IconButton(
                icon: !searching ? Icon(Icons.search) : Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    this.searching = !this.searching;
                  });
                })
          ],
          backgroundColor: Colors.indigo[700]),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailOfert()));
              },
              child: Card(
                margin: EdgeInsets.all(5),
                shadowColor: Colors.black,
                color: Colors.indigo[50],
                elevation: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 5),
                      child: Text(
                        "Oferta del día",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Stack(
                          children: [
                            Image.network(
                              "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                              width: 400,
                              alignment: Alignment.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                              child: Text(
                                "-30%",
                                style: TextStyle(
                                    backgroundColor: Colors.red,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Drone quadcoptero DJI BoxMaster 5000",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text("\$250000",
                              style: TextStyle(
                                  fontSize: 20.5,
                                  color: Colors.black54,
                                  decoration: TextDecoration.lineThrough)),
                          Text(
                            "\$175000",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigo[700]),
                            //color: Colors.white,
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            label: Text("Agregar al carrito",
                                style: TextStyle(
                                  // fontFamily: 'Product Sans',
                                  //fontSize: 25,
                                  color: Colors.white,
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void buscar(BuildContext context) {
    // traerArticulos(busqueda.text, qery).then((resbq) {
    //  resbusqueda = resbq;
    // });
    // if (resbusqueda.length < 1) {
    // Scaffold.of(context).showSnackBar(SnackBar(
    //    content: Text(
    // 'No se encontraron artículos',
    // style: TextStyle(fontSize: 20),
    //  )));
  }
}

Widget _listArticulos() {
  // return resbusqueda.length != 0
  //     ? ListView.builder(
  //        shrinkWrap: true,
  //      itemCount: resbusqueda.length,
  //  itemBuilder: (context, posicion) {
  //      return AgregarArticuloCard(resbusqueda[posicion]);
  //  })
  //  : Container();
}

Widget _searchBar() {
  return Column(
    children: [
      Container(
          color: Colors.indigo[700],
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: busqueda,
                    decoration: InputDecoration(
                        hintText: "Buscar drones, servicios y más",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none),
                  )),
                  FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        // setState(() {
                        //   // resbusqueda.clear();
                        //   buscar(context);
                        // });
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search),
                          Text("Buscar"),
                        ],
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => Carrito(carrito)));
                    },
                    // label: Text(""),
                  ),
                ],
              ),
            ],
          )),
      Expanded(child: _listArticulos()),
    ],
  );
}
