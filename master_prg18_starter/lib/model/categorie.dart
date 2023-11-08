import '../commons/constant_assets.dart';

class Categorie {
  int? _id;
  String? _libelle;
  String? _icon;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get libelle => _libelle;
  String? get icon => _icon;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Categorie({
    int? id,
    String? libelle,
    String? icon,String? createdAt,
    String? updatedAt}){
    _id = id;
    _libelle = libelle;
    _icon = icon;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Categorie.fromJson(dynamic json){
    _id = json["id"];
    _libelle = json["libelle"];
    _icon = json["icon"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["libelle"] = _libelle;
    map["icon"] = _icon;
    map["created_at"] = _createdAt;
    map["id"] = _updatedAt;

    return map;
  }
}

//Sample Data
