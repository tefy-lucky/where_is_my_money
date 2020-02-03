class Bro {
  final int id;
  final String name;
  final double amount;
  final bool isPaid;

  Bro({this.id, this.name, this.amount, this.isPaid});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'isPaid': isPaid
    };
  }
}
