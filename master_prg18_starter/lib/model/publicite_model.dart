import 'package:master_prg18_starter/commons/constant_assets.dart';

class PubliciteCardModel {
  final String title;
  final String imageUrl;

  PubliciteCardModel(this.title,this.imageUrl);
}

//Sample Data
List<PubliciteCardModel> publiciteCardList = [
  PubliciteCardModel('Pub 1', kOnBoardingImage1),
  PubliciteCardModel('Pub 2', kOnBoardingImage2),
  PubliciteCardModel('Pub 3', kOnBoardingImage3)
];
