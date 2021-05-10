import 'dart:convert';
import 'dart:io';
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
      'https://droser.tech/api/auth/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'password_confirmation': passwdconfirm,
        'direccion': direccion,
        'name': name,
        'telefono': phone,
        'documento': documento,
        'idciudad': city,
        'tipo_documento': "1",
      }),
    );
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      exito = true;
      print('${response.body}');
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
  return exito;
}

Future<UsuarioLog> signIn({String email, String password}) async {
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/auth/login/',
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
      "https://droser.tech/api/ciudades",
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

Future<List<IDocument>> getIDtypes(BuildContext context) async {
  try {
    final http.Response response = await http.get(
      "https://droser.tech/api/tdocumentos",
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
      List<IDocument> coursesList = <IDocument>[];
      for (var i = 0; i < jsonlist["data"].length; i++) {
        IDocument ciu = new IDocument(
            estado: jsonlist["data"][i]["idtipo_documento"],
            idtipo: jsonlist["data"][i]["estado"],
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

Future<UsuarioRegistradoProfile> getUserInfo(
    BuildContext context, String tokn, String userid) async {
  try {
    final http.Response response = await http.get(
        "https://droser.tech/api/user/" + userid,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer " + tokn,
        });
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');
      //List<UsuarioRegistrado> ofertList = <UsuarioRegistrado>[];
      UsuarioRegistradoProfile us = new UsuarioRegistradoProfile(
          nombre: jsonlist["data"][0]["nombre"],
          ciudad: jsonlist["data"][0]["ciudad"],
          direccion: jsonlist["data"][0]["direccion"],
          documento: jsonlist["data"][0]["documento"],
          email: jsonlist["data"][0]["email"],
          telefono: jsonlist["data"][0]["telefono"],
          tipodocu: jsonlist["data"][0]["tipo_documento"],
          estado: jsonlist["data"][0]["estado"].toString());
      return us;
    } else {
      print("request failed");
      print('${response.body}');
    }
  } catch (e) {}
}

Future<bool> putUserInfo(
    String email,
    String tipodocumento,
    String direccion,
    String name,
    String city,
    String phone,
    String documento,
    BuildContext context,
    String tokn,
    String userid) async {
  try {
    int estado = 1;
    bool exito = false;
    final http.Response response =
        await http.put("https://droser.tech/api/user/" + userid,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: "Bearer " + tokn,
            },
            body: jsonEncode(<String, String>{
              'nombre': name,
              'documento': documento,
              'direccion': direccion,
              'email': email,
              'telefono': phone,
              'estado': "1",
              'tipo_documento': tipodocumento,
              'ciudad': city,
            }));
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      print('${response.body}');

      return exito;
    } else {
      print("request failed");
      print('${response.body}');
    }
  } catch (e) {}
}

Future<List<Ofert>> getArticles(BuildContext context, String tokn) async {
  List<Ofert> ofertList = <Ofert>[];
  try {
    final http.Response response = await http
        .get("https://droser.tech/api/articulos", headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + tokn,
    });
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');

      for (var i = 0; i < jsonlist["data"].length; i++) {
        Ofert of = new Ofert(
            nombre: jsonlist["data"][i]["nombre"],
            categoria: jsonlist["data"][i]["categoria"],
            descripcion: jsonlist["data"][i]["descripcion"],
            precio: jsonlist["data"][i]["precio"],
            dto: jsonlist["data"][i]["dto"].toString(),
            cantidad: jsonlist["data"][i]["cantidad"]);
        ofertList.add(of);
      }
    } else {
      print("request failed");
      print('${response.body}');
    }
  } catch (e) {}
  return ofertList;
}

Future<List<Category>> getCategories(BuildContext context, String tokn) async {
  List<Category> ofertList = <Category>[];
  try {
    final http.Response response = await http
        .get("https://droser.tech/api/categorias", headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + tokn,
    });
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');

      for (var i = 0; i < jsonlist["data"].length; i++) {
        Category of = new Category(
          imagen: "",
          nombre: jsonlist["data"][i]["nombre"],
          estado: jsonlist["data"][i]["categoria"],
          id: jsonlist["data"][i]["descripcion"],
        );
        ofertList.add(of);
      }
    } else {
      print("request failed");
      print('${response.body}');
    }
  } catch (e) {}
  return ofertList;
}
