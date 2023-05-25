class Envio {
  late DateTime fecha;
  late String estado;
  late String destino;
  late String id;

  Envio(
    this.id,
    this.estado,
    this.destino,
    this.fecha,
  );

  Envio.fromJson(Map<String, dynamic> json) {
    fecha = DateTime.parse(json['fecha']);
    estado = json['estado'];
    destino = json['destino'];
    id = json['id'];
  }

  avanzarEstado() {
    var estados = ['Creado', 'Preparando', 'En camino', 'Entregado'];
    if (estado == estados[0]) {
      estado = estados[1];
    } else if (estado == estados[1]) {
      estado = estados[2];
    } else if (estado == estados[2]) {
      estado = estados[3];
    }
  }
}
