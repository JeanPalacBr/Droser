import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Models/userRegistered.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/profile.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  UsuarioRegistradoProfile user = new UsuarioRegistradoProfile();
  EditProfile(this.user);
  @override
  EditProfilestate createState() => EditProfilestate(this.user);
}

class EditProfilestate extends State<EditProfile> {
  UsuarioRegistradoProfile user = new UsuarioRegistradoProfile();
  EditProfilestate(this.user);

  TextEditingController _email = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _direccion = new TextEditingController();
  TextEditingController _documento = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  List<City> citiesL = <City>[];
  List<IDocument> documentsL = <IDocument>[];
  String ciudad = "Seleccione su ciudad";
  String selciuda = "Seleccione su ciudad";
  String selid = "Seleccione su tipo de documento";
  String selidocu = "Seleccione su tipo de documento";
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  @override
  void initState() {
    _loadCities();
    _loadIDtypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Droser",
        home: Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue[200], Colors.blue[400]],
                    stops: [0.75, 0.5, 0.9],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
            child: Scaffold(
                drawer: NavDrawer(),
                appBar: AppBar(
                  title: !searching
                      ? Text("Droser")
                      : TextField(
                          controller: busqueda,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                              hintText: "Busca drones, art??culos y m??s...",
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white),
                          onSubmitted: (busqueda) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SearchResult(busqueda)));
                          },
                        ),
                  actions: <Widget>[
                    Row(
                      children: [
                        IconButton(
                            icon: !searching
                                ? Icon(Icons.search)
                                : Icon(Icons.cancel),
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
                backgroundColor: Colors.transparent,
                body: Builder(
                  builder: (context) => Form(
                      child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Editar usuario",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Image(
                              image:
                                  AssetImage("assets/images/DroneLeaser.png")),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: containerText(
                              TextFormField(
                                autofocus: true,
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: user.email,
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: containerText(
                              TextFormField(
                                autofocus: true,
                                controller: _name,
                                decoration: new InputDecoration(
                                  labelText: "Nombre completo",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: user.nombre,
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: containerText(
                              DropdownButtonHideUnderline(
                                  child: new DropdownButton<String>(
                                hint: new Text(selciuda),
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    ciudad = newValue;
                                  });
                                  print(ciudad);
                                },
                                items: citiesL.map((data) {
                                  return DropdownMenuItem(
                                    value: data.idciudad.toString(),
                                    onTap: () {
                                      selciuda = data.nombre;
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        data.nombre,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: containerText(
                              TextFormField(
                                autofocus: true,
                                controller: _direccion,
                                decoration: new InputDecoration(
                                  labelText: "Direcci??n",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: user.direccion,
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: containerText(
                              TextFormField(
                                autofocus: true,
                                controller: _phone,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: "Tel??fono",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: user.telefono,
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: containerText(
                              DropdownButtonHideUnderline(
                                  child: new DropdownButton<String>(
                                hint: new Text(selidocu),
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    selid = newValue;
                                  });
                                  print(selid);
                                },
                                items: documentsL.map((data) {
                                  return DropdownMenuItem(
                                    value: data.idtipo.toString(),
                                    onTap: () {
                                      selidocu = data.nombre;
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        data.nombre,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: containerText(
                              TextFormField(
                                autofocus: true,
                                controller: _documento,
                                decoration: new InputDecoration(
                                  labelText: "Documento de identidad",
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: user.documento,
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.indigo[700]),
                                child: Text("Guardar cambios"),
                                onPressed: () {
                                  _onpressedSave(
                                    context,
                                    _name.value.text,
                                    _documento.value.text,
                                    _direccion.value.text,
                                    _email.value.text,
                                    _phone.value.text,
                                    "1",
                                    ciudad,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Los cambios han sido guardados"),
                                    duration: const Duration(seconds: 3),
                                  ));
                                  getuserprofile(context);
                                },
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfile()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Text("Atr??s"))
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ))));
  }

  _loadCities() {
    selciuda = user.ciudad;
    ciudad = user.ciudad;
    getCities(context).then((cities) {
      setState(() {
        citiesL = cities;
      });
    });
  }

  _loadIDtypes() {
    selid = user.tipodocu;
    selidocu = user.tipodocu;
    getIDtypes(context).then((documents) {
      setState(() {
        documentsL = documents;
      });
    });
  }

  Widget containerText(Widget widg) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo[700], width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: widg,
      ),
    );
  }

  Future<void> getuserprofile(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getUserInfo(context, shar.token, shar.userid).then((artic) {
      setState(() {
        if (artic != null) {
          usuario = artic;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserProfile()),
            (Route<dynamic> route) => false,
          );
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

  Future<void> _onpressedSave(
    var context,
    String nam,
    String docu,
    String direccion,
    String email,
    String phone,
    String tipodocu,
    String city,
  ) async {
    if (nam == "" || nam == null) {
      nam = user.nombre;
    }
    if (docu == "" || docu == null) {
      docu = user.documento;
    }
    if (direccion == "" || direccion == null) {
      direccion = user.direccion;
    }
    if (email == "" || email == null) {
      email = user.email;
    }
    if (phone == "" || phone == null) {
      phone = user.telefono;
    }
    if (tipodocu == "" || tipodocu == null) {
      tipodocu = user.tipodocu;
    }
    if (city == "" || city == null) {
      city = user.ciudad;
    }

    SharedPreferences _sharedPrefs;
    _sharedPrefs = await SharedPreferences.getInstance();
    String userid = _sharedPrefs.getString("userid");
    String tkn = _sharedPrefs.getString("tokn");
    putUserInfo(email, tipodocu, direccion, nam, city, phone, docu, context,
            tkn, userid)
        .then((user) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Los cambios han sido guardados"),
        duration: const Duration(seconds: 3),
      ));
    }).catchError((error) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error" + error.toString()),
        duration: const Duration(seconds: 3),
      ));
    }).timeout(Duration(seconds: 10), onTimeout: () {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Timeout error"),
        duration: const Duration(seconds: 3),
      ));
    });
  }
}
