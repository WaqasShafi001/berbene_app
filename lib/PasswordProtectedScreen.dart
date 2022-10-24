import 'dart:async';
import 'package:berbene_app/flow/bottomNavBar/statisticScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'style/appColors.dart';

const storedPasscode = '282528';

class PasswordProtectedScreen extends StatefulWidget {
  const PasswordProtectedScreen({Key? key}) : super(key: key);

  @override
  State<PasswordProtectedScreen> createState() =>
      _PasswordProtectedScreenState();
}

class _PasswordProtectedScreenState extends State<PasswordProtectedScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.selectedCategoryColor.withOpacity(0.9),
      body: Center(
        child: Card(
          color: AppColors.unselectedCategoryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: height * 0.5,
              width: width * 0.75,
              decoration: BoxDecoration(
                  color: AppColors.selectedCategoryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'you_are_accessing_a_password_protected_screen',
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 16,
                      ),
                    ).tr(),
                    Text(
                      'where_you_will_be_able_to_sync_feedbacks_and_local_cache',
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 16,
                      ),
                    ).tr(),
                    Text(
                      'button_below_to_enter_secure_password',
                      style: TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 16,
                      ),
                    ).tr(),
                    _defaultLockScreenButton(context),
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }

  _defaultLockScreenButton(BuildContext context) => MaterialButton(
        color: AppColors.mainGreenColor,
        child: Text(
          'verify',
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ).tr(),
        onPressed: () {
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: Text(
              'cancel',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: tr('cancel'),
            ).tr(),
          );
        },
      );

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: Text(
              'enter_secure_passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ).tr(),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            isValidCallback: () {
              Get.to(StatisticScreen());
            },
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: tr('delete'),
            ).tr(),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 6,
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}
