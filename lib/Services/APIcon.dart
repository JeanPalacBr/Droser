import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Models/userRegistered.dart';

import '../Models/userRegistered.dart';

Future<bool> signUp(
    {String email,
    String password,
    String direccion,
    String name,
    String city,
    String phone,
    String documento,
    String passwdconfirm}) async {
  bool exito = false;
  try {
    final http.Response response = await http.post(
      'https://pfinal.eastus.cloudapp.azure.com/api/auth/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'direccion': direccion,
        'name': name,
        'telefono': phone,
        'documento': documento,
        'idperfil_usuario': "1",
        'idciudad': "1",
        'password_confirmation': passwdconfirm
      }),
    );
//{"status":"Success","message":null,"data":{"id":20,"token":"20|qfXCgLFvNKpYr8I3lcIufmaTCzIwunDd3IIO8QXx"}}
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      exito = true;
      print('${response.body}');
    } else {
      print("signup failed");
      print('${response.body}');
    }
    return exito;
  } catch (e) {}
}

Future<UsuarioLog> signIn({String email, String password}) async {
  try {
    final http.Response response = await http.post(
      'https://pfinal.eastus.cloudapp.azure.com/api/auth/login/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> res = json.decode(response.body);
      UsuarioLog usrl = new UsuarioLog(
          email: email, token: res["data"]["token"], id: res["data"]["id"]);
      return usrl;
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
}

Future<List<City>> getCities(BuildContext context) async {
  try {
    final http.Response response = await http.get(
      "https://pfinal.eastus.cloudapp.azure.com/api/ciudades",
    );
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      //"{"data":[{"idciudad":1,"nombre":"Barranquilla","estado":1}]}"
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');
      // List<dynamic> coursesList2 = jsonlist["data"];
      print('${response.body}' + "okiiiiiiiiii");
      List<City> coursesList = <City>[];
      for (var i = 0; i < jsonlist["data"].length; i++) {
        City ciu = new City(
            estado: jsonlist["data"][i]["estado"],
            idciudad: jsonlist["data"][i]["idciudad"],
            nombre: jsonlist["data"][i]["nombre"]);
        coursesList.add(ciu);
      }

      return coursesList;
    } else {
      print("request failed");
      print('${response.body}');
    }
  } catch (e) {}
}
