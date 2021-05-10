import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/categoryCard.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

class Coupons extends StatefulWidget {
  @override
  CouponsState createState() => CouponsState();
}

class CouponsState extends State<Coupons> {
  List<Category> cat = <Category>[];

  @override
  void initState() {
    getCategoriesa(context);
    Category imagen = new Category(
        imagen:
            "https://www.dronethusiast.com/wp-content/uploads/2016/04/dji-phantom-3-outdoor-quadcopter-drone-with-camera.jpg",
        nombre: "Imágenes");
    Category envios = new Category(
        imagen:
            "https://www.elheraldo.co/sites/default/files/articulo/2019/09/19/shutterstock_drone-1168x657.jpg",
        nombre: "Domicilios");
    Category topo = new Category(
        imagen:
            "https://i0.wp.com/novodrone.com/wp-content/uploads/2021/02/drones-profesionales-para-topografia.jpg?resize=640%2C281&ssl=1",
        nombre: "Topografía");
    Category vigilancia = new Category(
        imagen:
            "https://vivirenelpoblado.com/wp-content/uploads/2019/09/Drone-Policia-Colombia.jpg",
        nombre: "Vigilancia");
    Category fumigacion = new Category(
        imagen:
            "https://omegadrone.com.mx/wp-content/uploads/2020/11/DRONESAGRICULTURA-OMEGADRONE-AGRAST20-1-750x300.jpg",
        nombre: "Agricultura");
    cat.add(imagen);
    cat.add(envios);
    cat.add(topo);
    cat.add(vigilancia);
    cat.add(fumigacion);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Droser"), backgroundColor: Colors.blue[400]),
      drawer: NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _list()),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
        itemCount: cat.length,
        itemBuilder: (context, posicion) {
          return Container(
            color: Colors.white10,
            alignment: AlignmentDirectional.centerStart,
            child: categoryCard(cat[posicion]),
          );
        });
  }

  Future<void> getCategoriesa(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getCategories(context, shar.token).then((categ) {
      setState(() {
        cat = cat + categ;
      });
    }).catchError((error) {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}
