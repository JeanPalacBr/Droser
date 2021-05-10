import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lease_drones/Models/userRegistered.dart';
import 'package:lease_drones/UI/editProfile.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lease_drones/Services/APIcon.dart';

class UserProfile extends StatefulWidget {
  //UsuarioRegistrado usreg;

  UserProfile();
  @override
  UserProfilestate createState() => UserProfilestate();
}

class UserProfilestate extends State<UserProfile> {
  String emailed = "";
  String userid = "";
  UsuarioRegistradoProfile usuario = new UsuarioRegistradoProfile();
  UserProfilestate();
  @override
  void initState() {
    getuserprofile(context);
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
            title: Text("Droser"),
            backgroundColor: Colors.blue[400],
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 18, 0),
                child: Text(
                  emailed,
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ]),
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
                    child: Image.network(
                      "https://scontent.fctg1-3.fna.fbcdn.net/v/t1.6435-9/37043851_10216044568609042_7828755675776811008_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeGY3V07QAhtuPHoxR0RqZwI8t6iWEKq69ry3qJYQqrr2kiDhhYYzPpd2XcLOPbRSP-VPFJulkG3pB_NBMuVyRuu&_nc_ohc=PR4xY9PS1V0AX8nmAuL&_nc_ht=scontent.fctg1-3.fna&oh=1f678cb1fac53cb33a86a362a79520f9&oe=60AF3BF5",
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Text(
                      " " + usuario.nombre.toString(),
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
                      "Email: " + emailed,
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

  Future<void> getuserprofile(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getUserInfo(context, shar.token, shar.userid).then((artic) {
      setState(() {
        usuario = artic;
      });
    }).catchError((error) {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}
