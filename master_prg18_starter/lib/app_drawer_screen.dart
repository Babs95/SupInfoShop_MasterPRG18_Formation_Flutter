import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:master_prg18_starter/commons/constant_colors.dart';
import 'package:master_prg18_starter/commons/constant_string.dart';
import 'package:master_prg18_starter/commons/size_config.dart';
import 'package:master_prg18_starter/state_controller/provider/authentification_service.dart';
import 'package:master_prg18_starter/view/routes/routes.dart';

import 'commons/constant_assets.dart';
import 'commons/utls.dart';
import 'model/menu.dart';

class AppDrawerScreenState extends StatefulWidget {
  final bool isUserLogin;
  const AppDrawerScreenState({super.key, required this.isUserLogin});

  @override
  State<AppDrawerScreenState> createState() => _AppDrawerScreenStateState();
}

class _AppDrawerScreenStateState extends State<AppDrawerScreenState> {
  List<Menu> listMenu = [];
  Menu? selectedMenu;
  int selectedMenuIndex = 0;

  @override
  void initState() {
    listMenu = [
      Menu(
        id: 0,
        title: kHome,
        icon: kHomeIcon,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      Menu(
        id: 1,
        title: kProfile,
        icon: kProfileIcon,
        visible: widget.isUserLogin,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.profile);
        },
      ),
      Menu(
        id: 2,
        title: kLogin,
        icon: kLoginIcon,
        visible: !widget.isUserLogin,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.auth);
        },
      ),
      Menu(
        id: 3,
        title: kDisconnect,
        icon: kLogoutIcon,
        visible: widget.isUserLogin,
        onTap: _openAlertDialog,
      )
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kSplashBackgroundGreyColor,
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(10),
          bottom: getProportionateScreenWidth(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: getProportionateScreenWidth(10),
              ),
              height: getProportionateScreenWidth(200),
              child: DrawerHeader(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Image(
                        image: const AssetImage(KImageSplashScreen),
                        width: SizeConfig.isTablet
                            ? getProportionateScreenWidth(100)
                            : getProportionateScreenWidth(150),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close, color: kRedColor,),
                      )
                    ],
                  )
                ),
              ),
            ),
            Column(
              children: (List.generate(listMenu.length, (index) {
                Menu menu = listMenu[index];
                return Visibility(
                  visible: menu.visible ?? false,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      menu.icon ?? '',
                      color: selectedMenuIndex == menu.id
                          ? kPrimaryColor
                          : kDeepDarkPrimaryColor,
                      width: SizeConfig.isTablet ? 25 : 21,
                    ),
                    title: Text(
                        menu.title ?? '',
                      style: TextStyle(
                        color: selectedMenuIndex == menu.id
                            ? kPrimaryColor
                            : kDeepDarkPrimaryColor,
                        fontWeight: selectedMenuIndex == menu.id
                            ? FontWeight.bold
                            : FontWeight.w300,
                        fontSize: SizeConfig.isTablet ? 20 : 15,
                      ),
                    ),
                    selected: selectedMenuIndex == menu.id,
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      selectedMenu = menu;
                      menu.onTap();
                    },
                  ),
                );
              })),
            ),
          ],
        ),
      )
    );
  }

  //================== ACTIONS =========================
  _openAlertDialog() {
    showDialog(context: context, builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Column(
          children: [
            Text(
              'Vous êtes sur le point de vous déconnecter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.isTablet ? 25 : 16,
              ),
            ),
            const Divider(),
          ],
        ),
        content: Text(
          'Voulez vous vraiment continuer ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.isTablet ? 25 : 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Annuler',
                style: TextStyle(
                  color: kRedColor,
                  fontSize: SizeConfig.isTablet ? 25 : 16,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              AuthentificationService().signOut(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                kDisconnect,
                style: TextStyle(
                  fontSize: SizeConfig.isTablet ? 25 : 16,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}