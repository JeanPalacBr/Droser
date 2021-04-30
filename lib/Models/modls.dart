class UserInfo {
  final String token;
  final String username;
  final String name;

  UserInfo({this.token, this.username, this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}

class Cities {
  String nombre;
  int idciudad;
  int estado;
  List<dynamic> data;

  Cities({this.nombre, this.idciudad, this.estado, this.data});

  factory Cities.fromJson(Map<dynamic, dynamic> json) {
    return Cities(
      nombre: json['nombre'],
      idciudad: json['idciudad'],
      estado: json['estado'],
      data: json["data"],
    );
  }
}

class City {
  String nombre;
  int idciudad;
  int estado;

  City({this.nombre, this.idciudad, this.estado});

  factory City.fromJson(Map<dynamic, dynamic> json) {
    return City(
      nombre: json['nombre'],
      idciudad: json['idciudad'],
      estado: json['estado'],
    );
  }
}
