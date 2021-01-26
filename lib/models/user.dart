import 'package:ru/models/transaction.dart';

class User {
  final String fullName;
  final String email;
  final String iduffs;
  final String qrCodeUrl;
  final String profilePicture;
  final String cpf;
  final double balance;
  final List<Transactions> transactions;

  User({
    this.fullName,
    this.email,
    this.iduffs,
    this.qrCodeUrl,
    this.profilePicture,
    this.cpf,
    this.transactions,
    this.balance,
  });

  factory User.fromJson(json) {
    final user = json["user"];

    final transactions = (json["user"]["transactions"] as List)
        .map(
          (tr) => Transactions(
            description: tr["description"],
            name: tr["name"],
            price: double.parse("${tr["price"]}"),
            time: DateTime.parse(tr["time"]),
            type: tr["type"],
          ),
        )
        .toList();

    return User(
      cpf: user["cpf"],
      email: user["email"],
      fullName: user["full_name"],
      iduffs: user["iduffs"],
      profilePicture: user["profilePicture"],
      qrCodeUrl: user["qrCodeUrl"],
      transactions: transactions,
      balance: user["balance"],
    );
  }

  String get formatedCpf {
    final stringCpf = this.cpf.toString();
    return stringCpf.substring(0, 3) +
        '.' +
        stringCpf.toString().substring(3, 6) +
        '.' +
        stringCpf.toString().substring(6, 9) +
        '-' +
        stringCpf.toString().substring(9, 11);
  }
}
