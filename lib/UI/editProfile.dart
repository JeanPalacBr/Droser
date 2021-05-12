import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Models/userRegistered.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/Carrito.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

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
  TextEditingController _password = new TextEditingController();
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
                              hintText: "Busca drones, articulos y más...",
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
                body: Form(
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
                            image: AssetImage("assets/images/DroneLeaser.png")),
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
                                    padding: const EdgeInsets.only(left: 10.0),
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
                                labelText: "Dirección",
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
                                labelText: "Teléfono",
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
                                    padding: const EdgeInsets.only(left: 10.0),
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
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Atrás"))
                          ],
                        )
                      ],
                    ),
                  ),
                )))));
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
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo[700], width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: widg,
    );
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
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Registered')));
    }).catchError((error) {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    }).timeout(Duration(seconds: 10), onTimeout: () {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Timeout error")));
    });
  }
}
