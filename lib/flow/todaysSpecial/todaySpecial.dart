import 'package:berbene_app/apiModels/allProductApiModel.dart';
import 'package:berbene_app/apiModels/sliderApiModel.dart';
import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/controllers/navBarController.dart';
import 'package:berbene_app/controllers/sliderImagesController.dart';
import 'package:berbene_app/flow/homePage/homePageCategories.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/customAppBar.dart';
import 'package:berbene_app/widgets/homeFoodItem.dart';
import 'package:berbene_app/widgets/loadingWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'package:easy_localization/easy_localization.dart';

import '../productDetailScreen.dart';

class TodaysSpecial extends StatefulWidget {
  const TodaysSpecial({
    Key? key,
  }) : super(key: key);

  @override
  State<TodaysSpecial> createState() => _TodaysSpecialState();
}

class _TodaysSpecialState extends State<TodaysSpecial> {
  var sliderImagesController = Get.put(SliderImagesController());
  var allCategoryController = Get.find<CategoriesApiController>();

  int _current = 0;
  final CarouselController _controller = CarouselController();
  Future<AllProductsApiModel?>? future;
  Future<SliderAPIModel?>? sliderFuture;

  var gridView;
  var sliderView;
  @override
  void initState() {
    super.initState();
  }

  Future<void> reCallApi() async {
    setState(() {
      productController.apiCall.value = true;
    });
    productController.reCallProductApiCtr();
  }

  @override
  Widget build(BuildContext context) {
    var navBarController = Get.find<BottomBarController>();

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    sliderFuture = sliderImagesController.getSliderImages();
    future = productController.getAllProducts();

    return NotificationListener<ScrollNotification>(
      child: Obx(
        () => Scaffold(
            appBar: customAppBar(
              height: height,
              width: width,
              context: context,
            ),
            body: Stack(
              children: [
                !productController.apiCall.value
                    ? RefreshIndicator(
                        backgroundColor: AppColors.mainGreenColor,
                        color: AppColors.whiteColor,
                        onRefresh: () {
                          return navBarController.mesgString.value ==
                                  'Connected'
                              ? reCallApi().then((value) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: navBarController
                                                    .mesgString.value ==
                                                'Connected'
                                            ? Text("Updated").tr()
                                            : Text("Not connected to internet"),
                                        backgroundColor: AppColors
                                            .mainGreenColor
                                            .withOpacity(0.95),
                                        dismissDirection:
                                            DismissDirection.horizontal,
                                      ),
                                    );
                                  });
                                })
                              : Future.delayed(Duration(milliseconds: 0));
                        },
                        child: FutureBuilder<AllProductsApiModel?>(
                          future: future,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<ProductApiResponse> products = [];
                              products = snapshot.data!.response!
                                  .where((element) =>
                                      element.isFeatured == 1 ||
                                      element.isFeatured == true)
                                  .toList();
                              gridView = SliverGrid.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: height * 0.024,
                                crossAxisSpacing: width * 0.02,
                                childAspectRatio: 1.1,
                                children: List.generate(
                                  products.length,
                                  (index) => HomeFoofItem(
                                    index: index,
                                    onTap: () {
                                      print(
                                          'translation id is = ${products[index].translationId}');

                                      Get.to(
                                        ProductDetailScreen(
                                          title: products[index].title,
                                          titleAr: products[index].titleAr,
                                          price: products[index].price,
                                          ingredients:
                                              products[index].ingredients,
                                          ingredientsAr:
                                              products[index].ingredientsAr,
                                          nutrition:
                                              products[index].nutritionInfo,
                                          nutritionAr:
                                              products[index].nutritionInfoAr,
                                          sliderImages: products[index]
                                              .images!
                                              .map((e) => e.url)
                                              .toList(),
                                          trasnlationID:
                                              products[index].translationId,
                                                   isHalal: products[index].halal,
                                      isChilli: products[index].chilli,
                                      isPopular: products[index].popular,
                                      isVegiterian: products[index].vageterian,
                                        ),
                                      );
                                    },
                                    productImage: products[index].thumbnail,
                                    titleText:
                                        findLanguageController.isEnglish.value
                                            ? products[index].title
                                            : products[index].titleAr ?? '',
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return Center(
                                  child: Container(
                                height: height * 0.12,
                                width: width * 0.4,
                                child: MaterialButton(
                                  elevation: 0,
                                  color: navBarController.mesgString.value ==
                                          'Disconnected'
                                      ? AppColors.whiteColor
                                      : Colors.transparent,
                                  height: height * 0.3,
                                  minWidth: width * 0.3,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomLoadingForBerbene(),
                                      SizedBox(),
                                      navBarController.mesgString.value ==
                                              'Disconnected'
                                          ? Text(
                                              'Retry',
                                              style: TextStyle(
                                                color: AppColors.mainGreenColor,
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ));
                            }
                            return CustomScrollView(
                              scrollDirection: Axis.vertical,
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              slivers: [
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: height * 0.025,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: FutureBuilder<SliderAPIModel?>(
                                    future: sliderFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<ResponseObject> sliderImages = [];
                                        sliderImages = snapshot.data!.response!;
                                        sliderView = Container(
                                          height: height * 0.27,
                                          width: width,
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: width,
                                                  child: CarouselSlider(
                                                    options: CarouselOptions(
                                                      aspectRatio: 16 / 9,
                                                      enlargeCenterPage: true,
                                                      reverse: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      autoPlay: true,
                                                      onPageChanged:
                                                          (index, reason) {
                                                        setState(() {
                                                          _current = index;
                                                        });
                                                      },
                                                    ),
                                                    items: <Widget>[
                                                      for (var i = 0;
                                                          i <
                                                              sliderImages
                                                                  .length;
                                                          i++)
                                                        Builder(
                                                          builder: (context) =>
                                                              Container(
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                              child: Stack(
                                                                children: <
                                                                    Widget>[
                                                                  CachedNetworkImage(
                                                                    imageUrl:
                                                                        sliderImages[i].image ??
                                                                            '',
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Center(
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/no_image.png',
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image
                                                                            .asset(
                                                                      'assets/no_image.png',
                                                                    ),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.025,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: sliderImages
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  return GestureDetector(
                                                    onTap: () => _controller
                                                        .animateToPage(
                                                            entry.key),
                                                    child: Container(
                                                      width: 10.0,
                                                      height: 10.0,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2.0,
                                                              horizontal: 4.0),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: _current ==
                                                                  entry.key
                                                              ? AppColors
                                                                  .mainGreenColor
                                                              : AppColors
                                                                  .greyTextColor
                                                                  .withOpacity(
                                                                      0.3)),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      } else {
                                        return Center(
                                          child: CustomLoadingForBerbene(),
                                        );
                                      }
                                      return sliderView;
                                    },
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: height * 0.02,
                                  ),
                                ),
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.025),
                                  sliver: gridView,
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: height * 0.1,
                                  ),
                                ),
                              ],
                            );
                          },
                        ))
                    : Center(child: CustomLoadingForBerbene()),
                productController.isLoading2.value
                    ? Scaffold(
                        backgroundColor: Colors.black12,
                        body: Center(
                          child: CustomLoadingForBerbene(),
                        ),
                      )
                    : SizedBox(),
              ],
            )),
      ),
    );
  }
}
