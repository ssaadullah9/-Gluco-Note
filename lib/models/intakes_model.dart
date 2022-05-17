class Intakes {
  final String? email;
  final int? cal;
  final int? quantity;
  final String? category;
  final String? type;

  const Intakes({
    this.email,
    this.cal,
    this.quantity,
    this.category,
    this.type,
  });
  factory Intakes.empty() {
    return const Intakes(
        email: '', type: '', quantity: 0, cal: 0, category: '');
  }
  factory Intakes.fromDoc(Map<String, dynamic> dataDoc) {
    return Intakes(
      email: dataDoc['Email'],
      cal: dataDoc['intakes_Cal'],
      quantity: dataDoc['intakes_Quantity'],
      category: dataDoc['intakes_category'],
      type: dataDoc['intakes_type'],
    );
  }
}
