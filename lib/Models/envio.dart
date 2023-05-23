class Envio {
  late DateTime fecha;
  late String estado;
  late String destino;
  late String id;

  Envio(this.fecha, this.estado, this.destino, this.id);

  Envio.fromJson(Map<String, dynamic> json) {
    fecha = DateTime.parse(json['fecha']);
    estado = json['estado'];
    destino = json['destino'];
    id = json['id'];
  }
}
