import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:string_validator/string_validator.dart';

var globalContext;

class EditProfile extends StatefulWidget {
  String direccion = "Cra 22 # 11-12";
  String documento = "11111";
  String email = "asd@un.com";
  String nombre = "Pedrinho";
  String telefono = "+57123123";
  String ciudad = "1";
  String idperfilusuario = "1";
  EditProfile(
      {Key key,
      this.direccion,
      this.documento,
      this.email,
      this.nombre,
      this.telefono,
      this.ciudad,
      this.idperfilusuario})
      : super(key: key);
  @override
  EditProfilestate createState() => EditProfilestate(
      direccion, documento, email, nombre, telefono, ciudad, idperfilusuario);
}

//direccion:direccion, documento:documento, email:email,

void _onpressedSignUp(var context, String email, String _password,
    String direccion, String nam, String city, String phone, String docu) {
  signUp(
          email: email,
          password: _password,
          direccion: direccion,
          city: city,
          phone: phone,
          documento: docu,
          name: nam,
          passwdconfirm: _password)
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

Widget build(BuildContext context) {
  globalContext = context;
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
            backgroundColor: Colors.transparent,
            // resizeToAvoidBottomPadding: false,
            body: EditProfile(),
          )));
}

class EditProfilestate extends State<EditProfile> {
  String direccion = "Cra 22 # 11-12";
  String documento = "11111";
  String email = "asd@un.com";
  String nombre = "Pedrinho";
  String telefono = "+57123123";
  String ciudads = "1";
  String idperfilusuario = "1";
  EditProfilestate(
      direccion, documento, email, nombre, telefono, ciudad, idperfilusuario);
  //final GlobalKey<FormState> _signUpfkey = GlobalKey<FormState>();
  final _email = new TextEditingController();
  final _password = new TextEditingController();
  final _name = new TextEditingController();
  final _direccion = new TextEditingController();
  final _documento = new TextEditingController();
  final _phone = new TextEditingController();
  List<City> citiesL = <City>[];
  String ciudad = "Seleccione su ciudad";
  String selciuda = "Seleccione su ciudad";
  @override
  void initState() {
    _loadCities();
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
              backgroundColor: Colors.transparent,
              body: Form(
                  //key: MultipleKeys.signUpFormKey,
                  child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Editar perfil",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.edit,
                        size: 100,
                      ),
                      containerText(
                        TextFormField(
                          autofocus: true,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            labelText: "Email",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 18),
                            hintText: email,
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      containerText(
                        TextFormField(
                          autofocus: true,
                          controller: _name,
                          decoration: new InputDecoration(
                            labelText: "Nombre completo",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: nombre,
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      containerText(
                        TextFormField(
                          autofocus: true,
                          controller: _direccion,
                          decoration: new InputDecoration(
                            labelText: "Dirección",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: direccion,
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      containerText(
                        TextFormField(
                          autofocus: true,
                          controller: _phone,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: "Teléfono",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: telefono,
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      containerText(
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
                      containerText(
                        TextFormField(
                          autofocus: true,
                          controller: _documento,
                          decoration: new InputDecoration(
                            labelText: "Documento de identidad",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: documento,
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      containerText(TextFormField(
                        // key: MultipleKeys.signUpFormKey,
                        autofocus: true,
                        controller: _password,
                        decoration: new InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black)),
                        obscureText: true,
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigo[700]),
                            child: Text("Registrar cambios"),
                            onPressed: () {
                              if (isEmail(_email.value.text)) {
                                if (_password.text.length >= 6) {
                                  _onpressedSignUp(
                                      context,
                                      _email.value.text,
                                      _password.value.text,
                                      _direccion.value.text,
                                      _name.value.text,
                                      ciudad,
                                      _phone.value.text,
                                      _documento.value.text);
                                } else {
                                  Scaffold.of(globalContext)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    'contraseña demasiado corta',
                                    style: TextStyle(fontSize: 20),
                                  )));
                                }
                              } else {
                                Scaffold.of(globalContext)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  'Email invalido',
                                  style: TextStyle(fontSize: 20),
                                )));
                              }
                              Navigator.pop(globalContext);
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
              )),
            )));
  }

  _loadCities() {
    getCities(context).then((cities) {
      setState(() {
        citiesL = cities;
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
}
