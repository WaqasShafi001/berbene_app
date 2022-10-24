import 'package:berbene_app/flow/utils/capitilizeExtention.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/customAppBar.dart';
import 'package:berbene_app/widgets/tabs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? title;
  final String? titleAr;
  final int? price;
  final String? ingredients;
  final String? ingredientsAr;
  final String? nutrition;
  final String? nutritionAr;
  final int? isHalal;
  final int? isPopular;
  final int? isChilli;
  final int? isVegiterian;

  final List<String?>? sliderImages;

  final trasnlationID;

  const ProductDetailScreen({
    Key? key,
    this.trasnlationID,
    this.title,
    this.price,
    this.ingredients,
    this.nutrition,
    this.sliderImages,
    this.titleAr,
    this.ingredientsAr,
    this.nutritionAr,
    this.isHalal,
    this.isPopular,
    this.isChilli,
    this.isVegiterian,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _current = 0;
  var formatter = NumberFormat('#,##,000');

  final CarouselController _controllerr = CarouselController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print('this is new trasnlation id ${widget.trasnlationID}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        height: height,
        width: width,
        isBackButton: true,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          aspectRatio: 1.7,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          autoPlay: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: <Widget>[
                          for (var i = 0; i < widget.sliderImages!.length; i++)
                            Builder(
                              builder: (context) => Container(
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.sliderImages![i]!
                                        .replaceAll(' ', '%20')
                                        .trim(),
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                        'assets/no_image.png',
                                        height: height,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/no_image.png',
                                    ),
                                    fit: BoxFit.fill,
                                    width: width,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          widget.sliderImages!.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controllerr.animateToPage(entry.key),
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == entry.key
                                    ? AppColors.mainGreenColor
                                    : AppColors.greyTextColor.withOpacity(0.3)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: height * 0.095,
                      width: width * 0.65,
                      child: Align(
                        alignment: findLanguageController.isEnglish.value
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          findLanguageController.isEnglish.value
                              ? "${widget.title!.capitalizeFirstofEach}"
                              : "${widget.titleAr!.capitalizeFirstofEach}",
                          maxLines: 3,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.mainGreenColor,
                            fontSize: height * 0.017,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Material(
                      elevation: 2,
                      color: AppColors.mainGreenColor,
                      type: MaterialType.button,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                          vertical: height * 0.005,
                        ),
                        child: Text(
                          '${formatter.format(widget.price)} IQD',
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: height * 0.016,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.05,
                width: width,
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.036),
                  child: Row(
                    children: [
                      widget.isHalal == 1
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.mainGreenColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image.asset(
                                    'assets/halal.png',
                                    height: height * 0.02,
                                    color: AppColors.mainGreenColor,
                                  )),
                            )
                          : SizedBox(),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      widget.isPopular == 1
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.mainGreenColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/fire.png',
                                    height: height * 0.02,
                                    color: AppColors.mainGreenColor,
                                  )),
                            )
                          : SizedBox(),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      widget.isChilli == 1
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.mainGreenColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image.asset(
                                    'assets/chilli.png',
                                    height: height * 0.02,
                                    color: AppColors.mainGreenColor,
                                  )),
                            )
                          : SizedBox(),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      widget.isVegiterian == 1
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.mainGreenColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Image.asset(
                                    'assets/onion.png',
                                    height: height * 0.02,
                                    color: AppColors.mainGreenColor,
                                  )),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                height: height * 0.7,
                width: width,
                color: Colors.transparent,
                child: ContainedTabBarView(
                  tabBarProperties: TabBarProperties(
                    indicatorColor: AppColors.mainGreenColor,
                    labelColor: AppColors.mainGreenColor,
                    unselectedLabelColor: AppColors.greyTextColor,
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.greyTextColor,
                    ),
                  ),
                  tabs: [
                    Text(
                      'ingredients',
                      style: TextStyle(
                        color: AppColors.mainGreenColor,
                        fontSize: height * 0.016,
                      ),
                    ).tr(),
                    Text(
                      'nutritional_information',
                      style: TextStyle(
                        color: AppColors.mainGreenColor,
                        fontSize: height * 0.016,
                      ),
                    ).tr(),
                  ],
                  views: [
                    Tab1_ingredients(
                      width: width,
                      height: height,
                      texts: findLanguageController.isEnglish.value
                          ? widget.ingredients
                          : widget.ingredientsAr,
                    ),
                    Tab2_innformation(
                      width: width,
                      height: height,
                      texts: findLanguageController.isEnglish.value
                          ? widget.nutrition
                          : widget.nutritionAr,
                    ),
                  ],
                  onChange: (index) => print(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
