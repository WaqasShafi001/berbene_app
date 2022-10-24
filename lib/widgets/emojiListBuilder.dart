import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class EmojiListBuilder extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final int? itemCount;
  // final Function(int?)? onTap;
  final ValueSetter<int>? valueSetter;

  final List? controllerListOfBools;

  const EmojiListBuilder(
      {Key? key,
      this.title,
      this.height,
      this.width,
      this.itemCount,
      // this.onTap,
      this.controllerListOfBools,
      this.valueSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emojiList = [
      'assets/angry-emoji.png',
      'assets/confused-emoji.png',
      'assets/expressionless-emoji.png',
      'assets/smiling-emoji.png',
      'assets/awesome-emoji.png',
    ];
    return Container(
      // height: height * 0.15,
      width: width,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height! * 0.01,
            ),
            Text(
              title!,
              style: TextStyle(fontSize: height! * 0.018),
            ).tr(),
            SizedBox(
              height: height! * 0.01,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.transparent,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: controllerListOfBools!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      // color: AppColors.selectedCategoryColor,
                      iconSize: height! * 0.06,
                      onPressed: () {
                        valueSetter!(index);
                      },
                      //onTap!(index),
                      // onPressed: () {
                      //   setState(() {
                      //     feedbackController
                      //         .updateListofBoolStaffBehaviour(index);
                      //   });
                      // },

                      splashColor: AppColors.mainGreenColor,
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: controllerListOfBools![index]
                                ? AppColors.mainGreenColor
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            emojiList[index],
                            // height: 100,
                            fit: BoxFit.cover,
                            height: controllerListOfBools![index]
                                ? height! * 0.06
                                : height! * 0.04,
                            // width: width*0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height! * 0.01,
            ),
            Container(
              height: 1,
              width: width! * 0.8,
              color: AppColors.greyTextColor.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
