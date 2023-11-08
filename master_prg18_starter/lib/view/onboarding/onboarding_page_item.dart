import 'package:flutter/cupertino.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/commons/size_config.dart';
import 'package:master_prg18_starter/model/onboarding_model.dart';

class OnBoardingPageItem extends StatelessWidget {
  final OnboardingModel model;
  const OnBoardingPageItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            image: AssetImage(model.image),
            height: SizeConfig.screenHeight25,
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: SizeConfig.isTablet ? 32 : 28,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            model.subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: SizeConfig.isTablet ? 20 : 15,
                fontWeight: FontWeight.bold
            ),
          ),

          Text(
            model.numPage,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: SizeConfig.isTablet ? 20 : 15,
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }

}