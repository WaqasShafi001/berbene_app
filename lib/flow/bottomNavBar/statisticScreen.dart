import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/customAppBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../controllers/allImagesController.dart';
import '../../controllers/feedbackApiController.dart';

class StatisticScreen extends StatefulWidget {
  // final bool isShowContainer
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  var allImagesController = Get.put(AllImagesController());
  var feedbackController = Get.find<FeedbackApiController>();

  @override
  void initState() {
    allImagesController.fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

    return Scaffold(
      appBar: customAppBar(
        height: height,
        width: width,
        context: context,
        isBackButton: true,
        isFromStatistic: true,
      ),
      body: Stack(
        children: [
          Obx(
            () => Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 25,
                    ),
                    itemCount: allImagesController.allImagesList.length,
                    itemBuilder: (BuildContext context, index) =>
                        CachedNetworkImage(
                      imageUrl: allImagesController.allImagesList[index]
                          .replaceAll(' ', '%20')
                          .trim(),
                      memCacheWidth: (width * 0.6).toInt(),
                      placeholder: (context, url) => Center(
                        child: Image.asset(
                          'assets/no_image.png',
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/no_image.png',
                      ),
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width > 600
                          ? height * 0.135
                          : height * 0.105,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.002,
                  width: width * 0.8,
                  color: AppColors.mainGreenColor,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('last_sync_time').tr(),
                    Text(allImagesController.lastSyncTime.value),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      allImagesController.deleteCache().then((value) {
                        allImagesController.fetchAllImages();
                        feedbackController.checkPasswordMatch2();
                      });
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  color: AppColors.mainGreenColor,
                  child: Text(
                    'sync_now',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                    ),
                  ).tr(),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
