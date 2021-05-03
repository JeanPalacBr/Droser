class UsuarioRegistrado {
  String nombre;
  String email;
  int documento;
  String direccion;
  String telefono;
  int idperfilusuario;
  String ciudad;
  String estado;

  UsuarioRegistrado(
      {this.documento,
      this.nombre,
      this.email,
      this.direccion,
      this.telefono,
      this.ciudad,
      this.idperfilusuario,
      this.estado});

  factory UsuarioRegistrado.fromJson(Map<String, dynamic> json) {
    return UsuarioRegistrado(
      nombre: json['name'],
      email: json['email'],
      direccion: json['direccion'],
    );
  }
}

class UsuarioRegistradoProfile {
  String nombre;
  String email;
  String documento;
  String direccion;
  String telefono;
  String idperfilusuario;
  String ciudad;
  String estado;

  UsuarioRegistradoProfile(
      {this.documento,
      this.nombre,
      this.email,
      this.direccion,
      this.telefono,
      this.ciudad,
      this.idperfilusuario,
      this.estado});

  factory UsuarioRegistradoProfile.fromJson(Map<String, dynamic> json) {
    return UsuarioRegistradoProfile(
      nombre: json['name'],
      email: json['email'],
      direccion: json['direccion'],
    );
  }
}

class UsuarioLog {
  String token;
  String email;
  int id;

  UsuarioLog({this.token, this.id, this.email});
  factory UsuarioLog.fromJson(Map<dynamic, dynamic> json) {
    return UsuarioLog(
        token: json['token'], id: json['id'], email: json["email"]);
  }
}
