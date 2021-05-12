import 'package:flutter/material.dart';
import 'package:lease_drones/Models/userRegistered.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/register.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';
import 'package:string_validator/string_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

var contextsc;
bool islogd = false;
String usrn;
String tokn;
bool invited = false;
UsuarioRegistradoProfile usuario;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    contextsc = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[200], Colors.blue[400]],
                  stops: [0.1, 0.3, 0.7],
                  begin: FractionalOffset.topRight,
                  end: FractionalOffset.bottomLeft)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            //resizeToAvoidBottomPadding: false,

            body: Islogged(),
          )),
    );
  }
}

class Islogged extends StatefulWidget {
  Isloggedstate createState() => Isloggedstate();
}

class Isloggedstate extends State {
  @override
  void initState() {
    usuario = new UsuarioRegistradoProfile(nombre: "");
    islogd = false;
    loadFromShared();
    super.initState();
  }

  final _email = new TextEditingController();
  final _password = new TextEditingController();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 75, 0, 0),
                child: Image(
                  image: AssetImage("assets/images/DroneLeaser.png"),
                )),
            Form(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
                    child: containerText(Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        autofocus: true,
                        cursorColor: Colors.white,
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "example@ejemplo.com",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
                    child: containerText(Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: "Contraseña",
                            labelStyle: TextStyle(color: Colors.white)),
                        obscureText: true,
                        controller: _password,
                      ),
                    )),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Text("Iniciar sesión",
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      if (isEmail(_email.value.text)) {
                        onpressedlogin(context, _email.value.text,
                            _password.value.text, true);
                        getuserprofile(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('Email o contraseña incorrectos'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Text("Registrate", style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Registrar()));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                //color: Colors.white,
                child: Text("Ingresar como Invitado",
                    style: TextStyle(
                      // fontFamily: 'Product Sans',
                      //fontSize: 25,
                      color: Colors.black,
                    )),
                onPressed: () {
                  setState(() {
                    invited = true;
                    islogd = true;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void onpressedlogin(
      var context, String email, String _password, bool remember) {
    signIn(email: email, password: _password).then((user) {
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Bienvenido'),
          duration: const Duration(seconds: 2),
        ));
        SharedPrefs shar = new SharedPrefs();
        shar.auth(user.id.toString(), user.token, user.email);
        setState(() {
          islogd = true;
          invited = false;
        });
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error" + error.toString()),
        duration: const Duration(seconds: 2),
      ));
    }).timeout(Duration(seconds: 20), onTimeout: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Verifique su conexión a internet"),
        duration: const Duration(seconds: 2),
      ));
    });
  }

  Future<void> getuserprofile(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getUserInfo(context, shar.token, shar.userid).then((artic) {
      setState(() {
        if (artic != null) {
          usuario = artic;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          usuario.nombre = "";
        }
      });
    }).catchError((error) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error" + error.toString()),
        duration: const Duration(seconds: 2),
      ));
    });
  }

  Widget containerText(Widget widg) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: widg,
    );
  }

  Future<void> loadFromShared() async {
    SharedPreferences _sharedPrefs;
    _sharedPrefs = await SharedPreferences.getInstance();

    String emailed = _sharedPrefs.getString("email");

    if (emailed == null || emailed == "") {
      islogd = false;
    } else {
      islogd = true;
    }
  }
}
