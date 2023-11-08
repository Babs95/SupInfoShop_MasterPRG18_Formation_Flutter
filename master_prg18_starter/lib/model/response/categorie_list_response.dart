import '../categorie.dart';

class CategorieResponse {
  String? _message;
  List<Categorie>? _categories;

  String? get message => _message;
  List<Categorie>? get categories => _categories;

  CategorieResponse({
    String? message,
    List<Categorie>? categories}){
    _message = message;
    _categories = categories;
  }

  CategorieResponse.fromJson(dynamic json){
    _message = json["message"];
    if(json["categories"] != null){
      _categories = [];
      json["categories"].forEach((cat) {
        _categories?.add(Categorie.fromJson(cat));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    if(_categories !=null){
      map["categories"] = _categories?.map((cat) => cat.toJson()).toList();
    }

    return map;
  }
}