import 'package:berbene_app/controllers/navBarController.dart';
import 'package:berbene_app/flow/CallUs/callUs.dart';
import 'package:berbene_app/flow/FeedBack/scanQRBarCode.dart';
import 'package:berbene_app/flow/homePage/homePageCategories.dart';
import 'package:berbene_app/flow/todaysSpecial/todaySpecial.dart';
import 'package:berbene_app/flow/utils/internetConnectivity.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/doubleBackToCloseApp.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../controllers/feedbackApiController.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;
  const BottomNavbar({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var navbarController = Get.put(BottomBarController());
  var feedbackController = Get.put(FeedbackApiController());

  int _selectedIndex = 0;

  final cron = Cron();

  late List<Widget> _pages;
  var listener;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.currentIndex;

    super.initState();
    _pages = <Widget>[
      HomePageCategories(),
      TodaysSpecial(),
      CallUs(),
      ScanQRBarCodeScreen(),
    ];

    cron.schedule(Schedule.parse('* 12 * * *'), () async {
      feedbackController.checkPasswordMatch2();
    });
  }

  @override
  void dispose() {
    listener.cancel();

    cron.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          navbarController.mesgString.value = 'Connected';

          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          navbarController.mesgString.value = 'Disconnected';
          navbarController.showOnline.value = false;
          setState(() {});

          break;
      }
    });

    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: AppColors.whiteColor,
          content: Text(
            'tap_back_again_to_leave',
            style: TextStyle(
                color: AppColors.mainGreenColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ).tr(),
        ),
        child: Stack(
          children: [
            IndexedStack(
              children: _pages,
              index: _selectedIndex,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffF7F9EC),
        fixedColor: AppColors.mainGreenColor,
        unselectedItemColor: AppColors.greyTextColor,
        selectedFontSize: height * 0.017,
        unselectedFontSize: height * 0.017,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home_on.png',
                height: height * 0.028,
                color: _selectedIndex == 0
                    ? AppColors.mainGreenColor
                    : AppColors.greyTextColor,
              ),
              label: tr('home')),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/categories_on.png',
                height: height * 0.028,
                color: _selectedIndex == 1
                    ? AppColors.mainGreenColor
                    : AppColors.greyTextColor,
              ),
              label: tr('todays_special')),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/call_on.png',
                height: height * 0.028,
                color: _selectedIndex == 2
                    ? AppColors.mainGreenColor
                    : AppColors.greyTextColor,
              ),
              label: tr('call_us')),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/feedbackEmoji.png',
                height: height * 0.028,
                color: _selectedIndex == 3
                    ? AppColors.mainGreenColor
                    : AppColors.greyTextColor,
              ),
              label: tr('feedback')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
