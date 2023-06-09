import 'package:intl/intl.dart';

extension ConvertToMoney on num {
  String get toMoney {
    final formatter = NumberFormat("#,##0", "en_US");
    return  formatter.format(this);
  }
}
