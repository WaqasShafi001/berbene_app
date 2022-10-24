import 'package:berbene_app/controllers/feedbackApiController.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/customAppBar.dart';
import 'package:berbene_app/widgets/customSnackBar.dart';
import 'package:berbene_app/widgets/emojiListBuilder.dart';
import 'package:berbene_app/widgets/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../controllers/navBarController.dart';

var feedbackController = Get.find<FeedbackApiController>();

class FeedBack extends StatefulWidget {
  const FeedBack({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var navBarController = Get.find<BottomBarController>();

  var emojiList = [
    'assets/angry-emoji.png',
    'assets/confused-emoji.png',
    'assets/expressionless-emoji.png',
    'assets/smiling-emoji.png',
    'assets/awesome-emoji.png',
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        context: context,
        height: height,
        width: width,
      ),
      body: Obx(
        () => Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              Container(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.5,
                          decoration: BoxDecoration(
                              color: AppColors.selectedCategoryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              '${feedbackController.scanBarcode.value}',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: height * 0.019,
                                color: AppColors.mainGreenColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        EmojiListBuilder(
                          height: height,
                          width: width,
                          title: 'taste_of_food',
                          itemCount:
                              feedbackController.listofBoolTasteOfFood.length,
                          controllerListOfBools:
                              feedbackController.listofBoolTasteOfFood,
                          valueSetter: (value) {
                            setState(() {
                              print('taste_of_food rating =  $value');
                              feedbackController
                                  .updateListofBoolTasteOfFood(value);
                              feedbackController.foodTasteRating.value =
                                  value + 1;
                              print(
                                  'this is rating for taste of food ${feedbackController.foodTasteRating.value}');
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        EmojiListBuilder(
                          height: height,
                          width: width,
                          title: 'services',
                          itemCount:
                              feedbackController.listofBoolServices.length,
                          controllerListOfBools:
                              feedbackController.listofBoolServices,
                          valueSetter: (value) {
                            setState(() {
                              print('services rating =  $value');
                              feedbackController
                                  .updateListofBoolServices(value);
                              feedbackController.servicesRating.value =
                                  value + 1;
                              print(
                                  'this is rating for services ${feedbackController.servicesRating.value}');
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        EmojiListBuilder(
                          height: height,
                          width: width,
                          title: 'cleanliness',
                          itemCount:
                              feedbackController.listofBoolCleanliness.length,
                          controllerListOfBools:
                              feedbackController.listofBoolCleanliness,
                          valueSetter: (value) {
                            setState(() {
                              print('cleanliness rating =  $value');
                              feedbackController
                                  .updateListofBoolCleanliness(value);
                              feedbackController.cleanliness.value = value + 1;
                              print(
                                  'this is rating for cleanliness ${feedbackController.cleanliness.value}');
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        EmojiListBuilder(
                          height: height,
                          width: width,
                          title: 'staff_behaviour',
                          itemCount: feedbackController
                              .listofBoolStaffBehaviour.length,
                          controllerListOfBools:
                              feedbackController.listofBoolStaffBehaviour,
                          valueSetter: (value) {
                            setState(() {
                              print('staff_behaviour rating =  $value');
                              feedbackController
                                  .updateListofBoolStaffBehaviour(value);
                              feedbackController.behaviourRating.value =
                                  value + 1;
                              print(
                                  'this is rating for behaviour ${feedbackController.behaviourRating.value}');
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.075,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Form(
                            autovalidateMode: AutovalidateMode.always,
                            child: TextFormField(
                              controller:
                                  feedbackController.phoneTextController,
                              style: TextStyle(
                                fontSize: height * 0.018,
                                color: AppColors.mainGreenColor,
                              ),
                              cursorColor: AppColors.mainGreenColor,
                              textAlign: TextAlign.start,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              validator: (value) {
                                String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                RegExp regExp = new RegExp(patttern);
                                if (value!.length == 0) {
                                  return 'Please enter mobile number';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: tr('your_phone_number'),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.mainGreenColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.mainGreenColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            controller: feedbackController.optionalComments,
                            style: TextStyle(
                              fontSize: height * 0.018,
                              color: AppColors.mainGreenColor,
                            ),
                            cursorColor: AppColors.mainGreenColor,
                            textAlign: TextAlign.start,
                            textInputAction: TextInputAction.done,
                            maxLines: 8,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: tr('your_comments_feedback'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.mainGreenColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.mainGreenColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (feedbackController.foodTasteRating.value == 0) {
                              customSnackbar(
                                title: tr('error'),
                                messageText:
                                    tr('please_rate_us_for_the_food_taste'),
                              );
                            } else if (feedbackController
                                    .servicesRating.value ==
                                0) {
                              customSnackbar(
                                title: tr('error'),
                                messageText:
                                    tr('please_rate_us_for_our_services'),
                              );
                            } else if (feedbackController.cleanliness.value ==
                                0) {
                              customSnackbar(
                                title: tr('error'),
                                messageText:
                                    tr('please_rate_us_for_our_cleanliness'),
                              );
                            } else if (feedbackController
                                    .behaviourRating.value ==
                                0) {
                              customSnackbar(
                                title: tr('error'),
                                messageText: tr(
                                    'please_rate_us_for_our_staff_behaviour'),
                              );
                            } else if (feedbackController
                                .phoneTextController.text.isEmpty) {
                              customSnackbar(
                                title: tr('error'),
                                messageText:
                                    tr('please_enter_your_phone_number'),
                              );
                            } else {
                              navBarController.mesgString.value == 'Connected'
                                  ? feedbackController.checkPasswordMatch()
                                  : feedbackController
                                      .submitFeedbackToDatabase();
                            }
                          },
                          color: AppColors.mainGreenColor,
                          height: height * 0.04,
                          minWidth: width * 0.42,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            'submit',
                            style: TextStyle(
                              fontSize: height * 0.02,
                              color: AppColors.whiteColor,
                            ),
                          ).tr(),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              feedbackController.isLoading.value
                  ? Container(
                      height: height,
                      width: width,
                      color: Colors.black12,
                      child: Center(
                        child: CustomLoadingForBerbene(),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
