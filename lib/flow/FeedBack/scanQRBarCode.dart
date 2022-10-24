import 'package:berbene_app/controllers/feedbackApiController.dart';
import 'package:berbene_app/flow/FeedBack/FeedBackScreen.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanQRBarCodeScreen extends StatefulWidget {
  const ScanQRBarCodeScreen({Key? key}) : super(key: key);

  @override
  State<ScanQRBarCodeScreen> createState() => _ScanQRBarCodeScreenState();
}

class _ScanQRBarCodeScreenState extends State<ScanQRBarCodeScreen> {
  var findFeedbackController = Get.find<FeedbackApiController>();

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff65AD46',
        '',
        true,
        ScanMode.BARCODE,
      );
      if (barcodeScanRes.isNotEmpty && barcodeScanRes != -1) {
        Get.to(FeedBack());
      } else {
        Get.back();
      }
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      findFeedbackController.scanBarcode.value = barcodeScanRes;
    });
  }

  Future<void> requestCameraPermission() async {
    final serviceStatus = await Permission.camera.isGranted;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
      scanBarcodeNormal();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
      Get.defaultDialog(
          content: Container(
              child: Center(
            child: Text('permission_denied').tr(),
          )),
          title: tr('alert'));
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        height: height,
        width: width,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Text(
              'please_scan_your_brbene_printed_receipt_QR_code_to_continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height * 0.02,
                color: AppColors.mainGreenColor,
              ),
            ).tr(),
          ),
          SizedBox(
            height: height * 0.06,
          ),
          SizedBox(
            height: height * 0.26,
            child: Image.asset(
              'assets/qrcode.png',
              color: AppColors.mainGreenColor,
            ),
          ),
          SizedBox(
            height: height * 0.06,
          ),
          MaterialButton(
            onPressed: () => requestCameraPermission(),
            color: AppColors.mainGreenColor,
            height: height * 0.045,
            minWidth: width * 0.32,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              'scan_order_number_now',
              style: TextStyle(
                fontSize: height * 0.019,
                color: AppColors.whiteColor,
              ),
            ).tr(),
          ),
        ],
      ),
    );
  }
}
