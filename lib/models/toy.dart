class Toy {
  final int id;
  final String toyType;
  final int dogId;

  Toy({
    this.id,
    this.toyType,
    this.dogId,
  });

  @override
  String toString() {
    return 'TOY => id: $id, toyType: $toyType, dogId: $dogId';
  }
}
