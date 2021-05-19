import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    String passwdconfirm,
    String tipodocumento}) async {
  bool exito = false;
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/auth/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'idciudad': city,
        'direccion': direccion,
        'telefono': phone,
        'tipo_documento': tipodocumento,
        'documento': documento,
        'password': password,
        'password_confirmation': passwdconfirm,
        'imagen:': ""
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

Future<UsuarioLog> signIn(
    {String email, String password, BuildContext context}) async {
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.body}'),
        duration: Duration(seconds: 5),
      ));
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
      UsuarioRegistradoProfile us = new UsuarioRegistradoProfile(
        nombre: jsonlist["data"][0]["nombre"],
        ciudad: jsonlist["data"][0]["ciudad"],
        direccion: jsonlist["data"][0]["direccion"],
        documento: jsonlist["data"][0]["documento"],
        email: jsonlist["data"][0]["email"],
        telefono: jsonlist["data"][0]["telefono"],
        tipodocu: jsonlist["data"][0]["tipo_documento"],
        estado: jsonlist["data"][0]["estado"].toString(),
        imagen: jsonlist["data"][0]["imagen"],
      );
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
    final http.Response response =
        await http.get("https://droser.tech/api/articulos");
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');

      for (var i = 0; i < jsonlist["data"].length; i++) {
        Ofert of = new Ofert(
            nombre: jsonlist["data"][i]["nombre"],
            categoria: jsonlist["data"][i]["categoria"].toString(),
            descripcion: jsonlist["data"][i]["descripcion"],
            idcategoria: jsonlist["data"][i]["idcategoria"].toString(),
            precio: jsonlist["data"][i]["precio"].toString(),
            dto: jsonlist["data"][i]["dto"].toString(),
            idarticulo: jsonlist["data"][i]["idarticulo"].toString(),
            cantidad: jsonlist["data"][i]["cantidad"],
            imagen: jsonlist["data"][i]["imagen"],
            disponible: "");
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
    final http.Response response =
        await http.get("https://droser.tech/api/categorias");
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
          estado: jsonlist["data"][i]["estado"].toString(),
          id: jsonlist["data"][i]["idcategoria_articulo"].toString(),
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

Future<List<Coupon>> getCoupons(BuildContext context, String tokn) async {
  List<Coupon> ofertList = <Coupon>[];
  try {
    final http.Response response =
        await http.get("https://droser.tech/api/cupones");
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');

      for (var i = 0; i < jsonlist["data"].length; i++) {
        Coupon of = new Coupon(
          idcupon: jsonlist["data"][i]["idcupon"],
          nombre: jsonlist["data"][i]["nombre"],
          codigo: jsonlist["data"][i]["codigo"],
          dcto: jsonlist["data"][i]["dcto"],
          cantidad: jsonlist["data"][i]["cantidad"],
          estado: jsonlist["data"][i]["estado"],
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

Future<List<Ofert>> searchByCategory(String idcat) async {
  List<Ofert> ofertList = <Ofert>[];
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/articulos/idcategoria/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'idcategoria': idcat}),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');
      for (var i = 0; i < jsonlist["data"].length; i++) {
        Ofert of = new Ofert(
            nombre: jsonlist["data"][i]["name"],
            categoria: jsonlist["data"][i]["idcategoria_articulo"].toString(),
            descripcion: jsonlist["data"][i]["descripcion"],
            idcategoria: jsonlist["data"][i]["idcategoria_articulo"].toString(),
            precio: jsonlist["data"][i]["precio"].toString(),
            dto: jsonlist["data"][i]["dcto"].toString(),
            idarticulo: jsonlist["data"][i]["idarticulo"].toString(),
            cantidad: jsonlist["data"][i]["cantidad"],
            imagen: jsonlist["data"][i]["imagen"],
            disponible: "");
        ofertList.add(of);
      }
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
  return ofertList;
}

Future<List<Ofert>> searchByName(String nombre) async {
  List<Ofert> ofertList = <Ofert>[];
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/articulos/nombre/',
      body: jsonEncode(<String, String>{'nombre': nombre}),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');

      for (var i = 0; i < jsonlist["data"].length; i++) {
        Ofert of = new Ofert(
            nombre: jsonlist["data"][i]["name"],
            categoria: jsonlist["data"][i]["idcategoria_articulo"].toString(),
            descripcion: jsonlist["data"][i]["descripcion"],
            idcategoria: jsonlist["data"][i]["idcategoria_articulo"].toString(),
            precio: jsonlist["data"][i]["precio"].toString(),
            dto: jsonlist["data"][i]["dcto"].toString(),
            idarticulo: jsonlist["data"][i]["idarticulo"].toString(),
            cantidad: jsonlist["data"][i]["cantidad"],
            imagen: jsonlist["data"][i]["imagen"],
            disponible: "");
        ofertList.add(of);
      }
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
  return ofertList;
}

Future<Coupon> verifyCoupon(String cupon) async {
  String res = "";
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/cupones/veri',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'codigo': cupon}),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');
      Coupon of = new Coupon(
        idcupon: jsonlist["data"]["idcupon"].toString(),
        nombre: jsonlist["data"]["nombre"].toString(),
        codigo: jsonlist["data"]["codigo"].toString(),
        dcto: jsonlist["data"]["dcto"].toString(),
        cantidad: jsonlist["data"]["cantidad"].toString(),
        estado: jsonlist["data"]["estado"].toString(),
      );
      return of;
    } else {
      if (response.statusCode == 404) {
        Map<dynamic, dynamic> jsonlist = json.decode(response.body);
        res = jsonlist["data"];
        Coupon of = new Coupon(
            idcupon: "0000",
            nombre: "no",
            codigo: "no",
            dcto: "0",
            cantidad: "0",
            estado: "0");
        return of;
      }
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
}

Future<String> availability(Rent renta) async {
  List<Ofert> ofertList = <Ofert>[];
  String res;
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/renta/disponibilidad',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idarticulo': renta.idarticulo,
        'cantidad': renta.cantidad.toString(),
        'fecha_fin': renta.fechaFin,
        'fecha_inicio': renta.fechaInicio,
        'hora_inicio': renta.horaInicio,
        'hora_fin': renta.horaFin,
        'direccion_entrega': renta.direccionEntrega,
        'idciudad': renta.idciudad,
        'idusuario': renta.idusuario.toString(),
        'idcupon': renta.idcupon,
        'valor': renta.valor.toString(),
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');
      res = jsonlist["data"];
      //       nombre: jsonlist["data"][i]["name"],
      //       categoria: jsonlist["data"][i]["idcategoria_articulo"].toString(),
      //       descripcion: jsonlist["data"][i]["descripcion"],
      //       precio: jsonlist["data"][i]["precio"],
      //       dto: jsonlist["data"][i]["dcto"].toString(),
      //       idarticulo: jsonlist["data"][i]["idarticulo"].toString(),
      //       cantidad: jsonlist["data"][i]["cantidad"]);
      //   ofertList.add(of);
      // }

    } else {
      if (response.statusCode == 404) {
        print('${response.body}');
        Map<dynamic, dynamic> jsonlist = json.decode(response.body);
        res = jsonlist["data"];
      } else {
        print("signup failed");
        print('${response.body}');
      }
    }
  } catch (e) {}
  return res;
}

Future<String> rent(Rent renta) async {
  List<Ofert> ofertList = <Ofert>[];
  String res;
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/renta',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idarticulo': renta.idarticulo,
        'cantidad': renta.cantidad.toString(),
        'fecha_fin': renta.fechaFin,
        'fecha_inicio': renta.fechaInicio,
        'hora_inicio': renta.horaInicio,
        'hora_fin': renta.horaFin,
        'direccion_entrega': renta.direccionEntrega,
        'idciudad': "1",
        'idusuario': renta.idusuario.toString(),
        'idcupon': renta.idcupon,
        'valor': renta.valor.toString(),
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');
      res = jsonlist["data"];
      //       nombre: jsonlist["data"][i]["name"],
      //       categoria: jsonlist["data"][i]["idcategoria_articulo"].toString(),
      //       descripcion: jsonlist["data"][i]["descripcion"],
      //       precio: jsonlist["data"][i]["precio"],
      //       dto: jsonlist["data"][i]["dcto"].toString(),
      //       idarticulo: jsonlist["data"][i]["idarticulo"].toString(),
      //       cantidad: jsonlist["data"][i]["cantidad"]);
      //   ofertList.add(of);
      // }

    } else {
      if (response.statusCode == 404) {
        print('${response.body}');
        Map<dynamic, dynamic> jsonlist = json.decode(response.body);
        res = jsonlist["data"];
      } else {
        print("signup failed");
        print('${response.body}');
      }
    }
  } catch (e) {}
  return res;
}

Future<List<Rented>> userRentsList(String idusuario) async {
  List<Rented> rentss = <Rented>[];
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/rentas/idusuario/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'idusuario': idusuario}),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');

      for (var i = 0; i < jsonlist["data"].length; i++) {
        Rented of = new Rented(
          idrenta: jsonlist["data"][i]["idrenta"].toString(),
          fechaInicio: jsonlist["data"][i]["fecha_inicio"].toString(),
          fechaFin: jsonlist["data"][i]["fecha_fin"],
          horaInicio: jsonlist["data"][i]["hora_inicio"],
          horaFin: jsonlist["data"][i]["hora_fin"].toString(),
          cantidad: jsonlist["data"][i]["cantidad"],
          direccionEntrega: jsonlist["data"][i]["direccion_entrega"],
          estado: jsonlist["data"][i]["estado"].toString(),
          valor: jsonlist["data"][i]["valor"].toString(),
          idarticulo: jsonlist["data"][i]["idarticulo"].toString(),
          idusuario: jsonlist["data"][i]["idusuario"].toString(),
          idciudad: jsonlist["data"][i]["idciudad"].toString(),
          created: jsonlist["data"][i]["created_at"].toString(),
        );
        rentss.add(of);
      }
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
  return rentss;
}

Future<UsuarioLog> logout({String email, String password}) async {
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/auth/logout/',
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

Future<void> droserBot(String mensaje) async {
  try {
    final http.Response response = await http.post(
      "https://api.telegram.org/bot1876251513:AAEXm_fFYtKnXw7GOJer8Qw3krfSgWB_9GE/sendMessage?chat_id=-589991124&text=" +
          mensaje.replaceAll(" ", "+"),
    );
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
}

Future<void> droserBotCS(String mensaje) async {
  try {
    final http.Response response = await http.post(
      "https://api.telegram.org/bot1876251513:AAEXm_fFYtKnXw7GOJer8Qw3krfSgWB_9GE/sendMessage?chat_id=-596685864&text=" +
          mensaje.replaceAll(" ", "+"),
    );
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
}

Future<ImageProvider<Object>> searchImage(String image) async {
  List<Ofert> ofertList = <Ofert>[];
  //img;
  try {
    final http.Response response = await http.post(
      'https://droser.tech/api/imagenes/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'image': image}),
    );
    ImageProvider<Object> img = Image.memory(response.bodyBytes).image;
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      // Map<dynamic, dynamic> jsonlist = json.decode(response.body);
      print('${response.body}');
      return img;
    } else {
      print("signup failed");
      print('${response.body}');
    }
  } catch (e) {}
}
