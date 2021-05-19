import 'package:flutter/material.dart';
import 'package:lease_drones/UI/Messengers.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/about.dart';
import 'package:lease_drones/UI/chat.dart';
import 'package:lease_drones/UI/coupons.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/profile.dart';
import 'package:lease_drones/UI/rentsActive.dart';
import 'package:lease_drones/UI/rentsHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Catalog.dart';
import 'categories.dart';
import 'login.dart';

class NavDrawer extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Image(
                  width: 120,
                  image: AssetImage("assets/images/DroneLeaser.png"),
                ),
                Text(
                    usuario.nombre != null ||
                            usuario.nombre == "" ||
                            invited == false
                        ? "Hola, " + usuario.nombre.split(" ")[0]
                        : "Hola, invitado",
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ],
            ),
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue[200], Colors.blue[400]],
                    stops: [0.1, 0.3, 0.7],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
          ),
          if (invited == true) ...{
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()))
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Catálogo'),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Catalog()))
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categorías'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories()))
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () => {sharedpreflogoutset(context)},
            ),
            ListTile(
              title: Text('Acerca de Droser'),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()))
              },
            ),
          } else ...{
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserProfile()))
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()))
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Mis rentas'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RentsHistory()))
              },
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Panel de control de renta'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RentsActive()))
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Catálogo'),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Catalog()))
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Carrito'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Carrito(carrito)))
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categorías'),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories()))
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Mensajería'),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()))
              },
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text(
                'Cuponmanía!!!',
                style: new TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient),
              ),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Coupons()))
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () => {sharedpreflogoutset(context)},
            ),
            ListTile(
              title: Text('Acerca de Droser'),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()))
              },
            ),
          },
        ],
      ),
    );
  }

  void sharedpreflogoutset(BuildContext context) async {
    SharedPreferences _sharedPrefs;
    _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString("email", "");
    _sharedPrefs.setString("tokn", "");
    _sharedPrefs.setString("userid", "");
    _sharedPrefs.clear();
    _sharedPrefs.remove("email");
    _sharedPrefs.remove("tokn");
    _sharedPrefs.remove("userid");
    islogd = false;
    invited = false;
    carrito.clear();
    usuario.nombre = "";
    usuario.email = "";
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }
}
