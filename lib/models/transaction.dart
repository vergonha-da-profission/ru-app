import 'package:timeago/timeago.dart' as timeago;

class Transaction {
  final String name;
  final String type;
  final double price;
  final String description;
  final DateTime time;

  Transaction({
    this.name,
    this.type,
    this.price,
    this.description,
    this.time,
  });

  get parsedDate {
    timeago.setLocaleMessages('br', timeago.PtBrMessages());

    return timeago.format(this.time, locale: 'br');
  }
}
