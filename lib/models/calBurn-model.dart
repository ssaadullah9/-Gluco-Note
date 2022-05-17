class CalBurned {
  final String? email;
  final int? cal;
  final int? per;
  final String? type;

  const CalBurned({
    required this.email,
    required this.cal,
    required this.per,
    required this.type,
  });

  factory CalBurned.empty() {
    return CalBurned(email: '', cal: 0, per: 0, type: '');
  }
  factory CalBurned.fromDoc(Map<String, dynamic> dataDoc) {
    return CalBurned(
        email: dataDoc['Email'],
        cal: dataDoc['ex_cal'],
        per: dataDoc['ex_per'],
        type: dataDoc['ex_type']);
  }
}
