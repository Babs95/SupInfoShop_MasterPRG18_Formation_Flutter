import 'package:flutter/cupertino.dart';

class Menu {
  int? _id;
  String? _title;
  String? _icon;
  bool? _visible;
  GestureTapCallback _onTap;

  int? get id => _id;
  String? get title => _title;
  String? get icon => _icon;
  bool? get visible => _visible;
  GestureTapCallback get onTap => _onTap;


  Menu({
    int? id,
    String? title,
    String? icon,
    bool visible = true,
    required GestureTapCallback onTap,
  }): _onTap = onTap {
    _id = id;
    _title = title;
    _icon = icon;
    _visible = visible;
  }
}