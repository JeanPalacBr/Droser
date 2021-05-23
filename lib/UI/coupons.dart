import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/couponCard.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

class Coupons extends StatefulWidget {
  @override
  CouponsState createState() => CouponsState();
}

class CouponsState extends State<Coupons> {
  List<Coupon> cupons = <Coupon>[];
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  @override
  void initState() {
    getCouponsa(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.purple[500], Colors.purple[900]],
                stops: [0.1, 0.3, 0.7],
                begin: FractionalOffset.bottomLeft,
                end: FractionalOffset.topRight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: !searching
                ? Text("Droser")
                : TextField(
                    controller: busqueda,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        hintText: "Busca drones, artículos y más...",
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white),
                    onSubmitted: (busqueda) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult(busqueda)));
                    },
                  ),
            actions: <Widget>[
              Row(
                children: [
                  IconButton(
                      icon:
                          !searching ? Icon(Icons.search) : Icon(Icons.cancel),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: NavDrawer(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: _list()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return cupons.length > 0
        ? ListView.builder(
            itemCount: cupons.length,
            itemBuilder: (context, posicion) {
              return Container(
                color: Colors.white10,
                alignment: AlignmentDirectional.centerStart,
                child: CouponCard(cupons[posicion]),
              );
            })
        : Column(
            children: [
              Text(
                "No se encontraron cupones, vuelve más tarde",
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new CircularProgressIndicator(
                    backgroundColor: Colors.white),
              )
            ],
          );
  }

  Future<void> getCouponsa(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getCoupons(context, shar.token).then((cupo) {
      setState(() {
        cupons = cupo;
      });
    }).catchError((error) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error" + error.toString()),
        duration: Duration(seconds: 5),
      ));
    });
  }
}
