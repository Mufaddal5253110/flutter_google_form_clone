import 'package:flutter/cupertino.dart';

class Global {
  static height(BuildContext context) => MediaQuery.of(context).size.height;
  static width(BuildContext context) => MediaQuery.of(context).size.width;
}
