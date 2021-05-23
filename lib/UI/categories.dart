import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/categoryCard.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/searchResult.dart';
import 'package:lease_drones/ViewModels/sharedPrefs.dart';

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  List<Category> cat = <Category>[];
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  @override
  void initState() {
    getCategoriesa(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  icon: !searching ? Icon(Icons.search) : Icon(Icons.cancel),
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
    return cat.length > 0
        ? ListView.builder(
            itemCount: cat.length,
            itemBuilder: (context, posicion) {
              return Container(
                color: Colors.white10,
                alignment: AlignmentDirectional.centerStart,
                child: CategoryCard(cat[posicion]),
              );
            })
        : Column(
            children: [
              Text(
                  "No se encontraron categorías, revise su conexión a internet"),
              Padding(
                padding: const EdgeInsets.all(15),
                child: new CircularProgressIndicator(
                    backgroundColor: Colors.white),
              )
            ],
          );
  }

  Future<void> getCategoriesa(BuildContext context) async {
    SharedPrefs shar = new SharedPrefs();
    getCategories(context, shar.token).then((categ) {
      setState(() {
        cat = categ;
      });
      for (var i = 0; i < cat.length; i++) {
        switch (cat[i].nombre) {
          case "Imágenes":
            {
              cat[i].imagen =
                  "https://www.dronethusiast.com/wp-content/uploads/2016/04/dji-phantom-3-outdoor-quadcopter-drone-with-camera.jpg";
            }
            break;
          case "Domicilios":
            {
              cat[i].imagen =
                  "https://www.elheraldo.co/sites/default/files/articulo/2019/09/19/shutterstock_drone-1168x657.jpg";
            }
            break;
          case "Topografía":
            {
              cat[i].imagen =
                  "https://i0.wp.com/novodrone.com/wp-content/uploads/2021/02/drones-profesionales-para-topografia.jpg?resize=640%2C281&ssl=1";
            }
            break;
          case "Vigilancia":
            {
              cat[i].imagen =
                  "https://vivirenelpoblado.com/wp-content/uploads/2019/09/Drone-Policia-Colombia.jpg";
            }
            break;
          case "Agricultura":
            {
              cat[i].imagen =
                  "https://omegadrone.com.mx/wp-content/uploads/2020/11/DRONESAGRICULTURA-OMEGADRONE-AGRAST20-1-750x300.jpg";
            }
            break;
          case "Básico":
            {
              cat[i].imagen =
                  "https://3dinsider.com/wp-content/uploads/2019/04/beginner-drones.jpg";
            }
            break;
          case "Piloto":
            {
              cat[i].imagen =
                  "https://enterprise-insights.dji.com/hs-fs/hubfs/Blog%20Images/How%20to%20Become%20a%20Professional%20Drone%20Pilot/Commercial%20Drone%20Pilot%20with%20L1.jpg?width=840&name=Commercial%20Drone%20Pilot%20with%20L1.jpg";
            }
            break;
          case "Altura":
            {
              cat[i].imagen =
                  "https://alldronesguide.com/wp-content/uploads/2020/01/High-Altitude-Drones.jpg";
            }
            break;
          case "Accesorios":
            {
              cat[i].imagen =
                  "https://www.radioshack.com.mx/medias/100011111.jpg-300ftw?context=bWFzdGVyfHJvb3R8MjM5NTd8aW1hZ2UvanBlZ3xoZjkvaDRjLzg5Nzc0NTc3NDE4NTQuanBnfGZhZWYxMzZhYTllNWQzYTFhZmRjZDZmNzA2MjJhNTY4MTc3OGYzODIzZDIzMGViNTA3ZmYyOTEwZmQ2MDQ3NjQ";
            }
            break;
        }
      }
    }).catchError((error) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error" + error.toString()),
        duration: Duration(seconds: 5),
      ));
    });
  }
}
