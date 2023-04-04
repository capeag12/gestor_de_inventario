class Item {
  String id;
  String nombre;
  double valor;

  Item(this.id, this.nombre, this.valor);

  //Override the equals method
  @override
  bool operator ==(Object other) => this.id == (other as Item).id;
}
