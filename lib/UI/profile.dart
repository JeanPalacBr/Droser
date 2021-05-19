import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/editProfile.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  //UsuarioRegistrado usreg;

  UserProfile();
  @override
  UserProfilestate createState() => UserProfilestate();
}

class UserProfilestate extends State<UserProfile> {
  String emailed = "";
  String userid = "";
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  //UsuarioRegistradoProfile usuario = new UsuarioRegistradoProfile();
  UserProfilestate();
  @override
  void initState() {
    // getuserprofile(context);
    if (usuario.imagen != null) {
      searchImage(usuario.imagen).then((aim) {
        setState(() {
          usuario.image = aim;
        });
      });
    }

    loadFromShared();
    super.initState();
    UserProfilestate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
      decoration: new BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blue[400],
        Colors.blue[200],
        Colors.white,
      ], stops: [
        0.4,
        0.3,
        0.3
      ], begin: FractionalOffset.topRight, end: FractionalOffset.bottomLeft)),
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
                    icon: !searching ? Icon(Icons.search) : Icon(Icons.cancel),
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Center(
                    child: new Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      height: 20.0,
                      width: 80.0,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: usuario.image == null
                        ? Image.network(
                            "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
                            width: 200,
                            alignment: Alignment.center,
                          )
                        : Image(
                            image: usuario.image,
                            width: 200,
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Text(
                      usuario.nombre.toString(),
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 36, 8, 15),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.confirmation_number),
                    Text(
                      "Documento ID: " + usuario.documento.toString(),
                      style: TextStyle(fontSize: 21),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alternate_email),
                    Text(
                      "Email: " + usuario.email.toString(),
                      style: TextStyle(fontSize: 21),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone),
                    Text(
                      "Teléfono: " + usuario.telefono.toString(),
                      style: TextStyle(fontSize: 21),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(
                      "Dirección: " + usuario.direccion.toString(),
                      style: TextStyle(fontSize: 21),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_city),
                    Text(
                      "Ciudad: " + usuario.ciudad.toString(),
                      style: TextStyle(fontSize: 21),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Text(
                      "Estado: Activo",
                      style: TextStyle(fontSize: 21),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(usuario)));
                        },
                        child: Text(
                          "Editar",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> loadFromShared() async {
    SharedPreferences _sharedPrefs;
    _sharedPrefs = await SharedPreferences.getInstance();

    emailed = _sharedPrefs.getString("email");
    userid = _sharedPrefs.getString("userid");
    if (emailed == null) {
      emailed = "esnull";
    }
  }

  // Future<void> getuserprofile(BuildContext context) async {
  //   SharedPrefs shar = new SharedPrefs();
  //   getUserInfo(context, shar.token, shar.userid).then((artic) {
  //     setState(() {
  //       usuario = artic;
  //     });
  //   }).catchError((error) {
  //     return Scaffold.of(context)
  //         .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
  //   });
  // }
}
