import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/commons/constant_string.dart';
import 'package:master_prg18_starter/commons/size_config.dart';
import 'package:master_prg18_starter/view/onboarding/onboarding_page_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../commons/constant_assets.dart';
import '../../model/onboarding_model.dart';
import '../../state_controller/onboarding_state_controller.dart';
import '../routes/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = Get.put(OnBoardingStateController());
  SharedPreferences? prefs;

  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setBool(FIRST_TIME, false);
  }

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final pages = [
      OnBoardingPageItem(
        model: OnboardingModel(
          image: kOnBoardingImage1,
          title: kOnboardingTitle1,
          subTitle: kOnboardingSubTitle1,
          bgColor: kOnBoardingPage1Color,
          numPage: kOnboardingCounter1
        ),
      ),
      OnBoardingPageItem(
        model: OnboardingModel(
            image: kOnBoardingImage2,
            title: kOnboardingTitle2,
            subTitle: kOnboardingSubTitle2,
            bgColor: kOnBoardingPage2Color,
            numPage: kOnboardingCounter2
        ),
      ),
      OnBoardingPageItem(
        model: OnboardingModel(
            image: kOnBoardingImage3,
            title: kOnboardingTitle3,
            subTitle: kOnboardingSubTitle3,
            bgColor: kOnBoardingPage3Color,
            numPage: kOnboardingCounter3
        ),
      )
    ];
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            slideIconWidget: const Icon(Icons.arrow_back_ios_new),
            enableSideReveal: true,
            liquidController: LiquidController(),
            onPageChangeCallback: (index) => controller.onPageChanged(index),
          ),
          Obx(
            ()=> Visibility(
              visible: controller.currentPage.value == 2,
              child: Positioned(
                bottom: 70,
                child: OutlinedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      side: const BorderSide(color: kDarkPrimaryColor),
                      padding: const EdgeInsets.all(20.0)
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        color: kDarkPrimaryColor,
                        shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            ()=> Positioned(
              bottom: 30,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage.value,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: kDarkPrimaryColor,
                  dotHeight: 4.0
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}