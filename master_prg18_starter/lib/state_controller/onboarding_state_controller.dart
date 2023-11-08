import 'package:get/get.dart';

class OnBoardingStateController extends GetxController {
  RxInt currentPage = 0.obs;

  onPageChanged(int currentIndex) => currentPage.value = currentIndex;
}