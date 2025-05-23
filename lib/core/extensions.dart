import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

extension WidgetExts on Widget {
  Widget centralize() => Center(child: this);
  Widget padX(double size) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: size), child: this);
  Widget padY(double size) =>
      Padding(padding: EdgeInsets.symmetric(vertical: size), child: this);
  Widget padAll(double size) =>
      Padding(padding: EdgeInsets.all(size), child: this);
}

extension MoneyExts on num {
  String get toMoney {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'N',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }
}
