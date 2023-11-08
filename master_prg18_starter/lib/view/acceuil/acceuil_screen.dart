import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:master_prg18_starter/commons/config.dart';
import 'package:master_prg18_starter/commons/size_config.dart';
import 'package:master_prg18_starter/model/my_user.dart';
import 'package:master_prg18_starter/model/response/categorie_list_response.dart';
import 'package:master_prg18_starter/state_controller/provider/authentification_service.dart';
import 'package:master_prg18_starter/view/routes/routes.dart';

import '../../commons/constant_colors.dart';
import '../../commons/constant_string.dart';
import '../../model/categorie.dart';
import '../../model/publicite_model.dart';

class AccueilScreen extends StatefulWidget {
  static const String routeName = '/home';
  final User? user;
  final MyUserModel? myUserModel;
  const AccueilScreen({super.key, this.user, this.myUserModel});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  List<Categorie> categories = [];
  bool _loading = false;

  @override
  void initState() {
    _getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20.0,),
          Visibility(
            visible: widget.myUserModel != null,
            child: Center(
              child: AutoSizeText.rich(
                TextSpan(
                  text: 'Bienvenue ',
                  style: const TextStyle(
                    fontSize: 18,
                    color: kDeepDarkPrimaryColor,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                        text: '${widget.myUserModel?.prenom} ${widget.myUserModel?.nom}',
                      style: const TextStyle(
                        color: kPrimaryColor
                      )
                    )
                  ]
                )
              ),
            ),
          ),
          const SizedBox(height: 10.0,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: Row(
              children: List.generate(publiciteCardList.isEmpty ? 0 : publiciteCardList.length, (index) {
                PubliciteCardModel item = publiciteCardList[index];
                return Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: getProportionateScreenWidth(SizeConfig.screenWidth70),
                  height: getProportionateScreenHeight(SizeConfig.screenHeight25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, right: getProportionateScreenWidth(SizeConfig.screenWidth50)),
            child: Text(
              kCategoryTitle,
              style: TextStyle(
                  fontSize: SizeConfig.isTablet ? 30 : 25,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 0.90,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(categories.isEmpty ? 0 : categories.length, (index) {
              Categorie item = categories[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.produit),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: kGreyLightColor,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                            color: kGreyColor,
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(
                                3.0,
                                3.0
                            )
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.libelle ?? '',
                        style: TextStyle(
                            color: kDarkPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.isTablet ? 25 : 18
                        ),
                      ),
                      Container(
                        width: getProportionateScreenWidth(SizeConfig.screenWidth25),
                        height: getProportionateScreenHeight(SizeConfig.screenHeight20),
                        child: Image.network(
                          item.icon!
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  _getCategories() async {
    setState(() {
      _loading = true;
    });

    try{
      CategorieResponse response = await Config.restClient!.getCategories();
      Logger().e('Get Categories response: $response');
      if(response.categories !=null){
        setState(() {
          _loading = false;
          categories = response.categories!;
        });
      }
    }catch(error){
      Logger().e('Get Categories error: $error');
      setState(() {
        _loading = false;
      });
    }
  }
}