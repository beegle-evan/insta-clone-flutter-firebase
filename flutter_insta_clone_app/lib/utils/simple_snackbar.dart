import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void SimpleSnackbar(BuildContext context, String s) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(s),
  ));
}
