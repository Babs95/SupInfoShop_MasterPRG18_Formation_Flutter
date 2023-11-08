import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/commons/size_config.dart';
import 'package:master_prg18_starter/model/produit.dart';

class ProduitScreen extends StatefulWidget {
  static const String routeName = '/produit';
  const ProduitScreen({super.key});

  @override
  State<ProduitScreen> createState() => _ProduitScreenState();
}

class _ProduitScreenState extends State<ProduitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produits'),),
      backgroundColor: kGreyLightColor,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.70
        ),
        shrinkWrap: true,
        itemCount: produits.length,
        itemBuilder: (BuildContext context, int index) {
          Produit produit = produits[index];
          return Container(
            padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Column(
              children: [
                Container(
                  width: getProportionateScreenWidth(SizeConfig.screenWidth30),
                  height: getProportionateScreenHeight(SizeConfig.screenHeight25),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        produit.image
                      ),
                      fit: BoxFit.fitWidth
                    )
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Text(
                      produit.libelle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: kDeepDarkPrimaryColor,
                        fontSize: SizeConfig.isTablet ? 20 : 15,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        produit.prix.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: kGreenColor,
                            fontSize: SizeConfig.isTablet ? 20 : 15,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Logger().i('${produit.libelle} ajoutée au panier !');
                        },
                        child: const Icon(
                          Icons.shopping_bag,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}