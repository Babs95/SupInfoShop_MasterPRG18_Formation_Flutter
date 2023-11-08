import '../commons/constant_assets.dart';

class Produit {
  final int id;
  final String libelle;
  final String image;
  final num prix;

  Produit(this.id,this.libelle,this.image,this.prix);
}

//Sample Data
List<Produit> produits = [
  Produit(1,'Iphone 11', kProduitImage1, 275000),
  Produit(2,'Iphone 12', kProduitImage2, 455000),
  Produit(3,'Iphone 14 Pro Max', kProduitImage3, 1224000),
];
