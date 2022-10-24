import 'package:berbene_app/controllers/allImagesController.dart';
import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/controllers/categoryPageController.dart';
import 'package:berbene_app/controllers/navBarController.dart';
import 'package:berbene_app/controllers/productApiController.dart';
import 'package:berbene_app/flow/homePage/productSection.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:berbene_app/widgets/customAppBar.dart';
import 'package:berbene_app/widgets/loadingWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../controllers/updateDeviceDataController.dart';
import '../bottomNavBar/statisticScreen.dart';
import 'categorySection.dart';
import 'package:easy_localization/easy_localization.dart';

var productController = Get.find<ProductApiController>();

class HomePageCategories extends StatefulWidget {
  const HomePageCategories({Key? key}) : super(key: key);

  @override
  State<HomePageCategories> createState() => _HomePageCategoriesState();
}

class _HomePageCategoriesState extends State<HomePageCategories> {
  PageController pageController = PageController();
  var putPageController = Get.put(GetPageController());
  var allCategoryController = Get.find<CategoriesApiController>();
  ItemScrollController scrollController = ItemScrollController();
  var navBarController = Get.find<BottomBarController>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> reCallApi() async {
    setState(() {
      allCategoryController.apiCall.value = true;
      allCategoryController.reCallHomeApiCtr();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        height: height,
        width: width,
        context: context,
      ),
      body: Obx(
        () => allCategoryController.isLoading.value
            ? Center(
                child: CustomLoadingForBerbene(),
              )
            : Stack(
                children: [
                  StatisticScreen(),
                  Container(
                    height: height,
                    width: width,
                    color: Colors.white,
                  ),
                  SmartRefresher(
                    controller: _refreshController,
                    header: WaterDropMaterialHeader(
                      backgroundColor: AppColors.mainGreenColor,
                    ),
                    onRefresh: () async {
                      return navBarController.mesgString.value == 'Connected'
                          ? reCallApi().then((value) {
                              Future.delayed(Duration(seconds: 2), () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        navBarController.mesgString.value ==
                                                'Connected'
                                            ? Text("Updated").tr()
                                            : Text("not_connected_to_internet")
                                                .tr(),
                                    backgroundColor: AppColors.mainGreenColor
                                        .withOpacity(0.95),
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                  ),
                                );
                              });
                              _refreshController.refreshCompleted();
                            })
                          : Future.delayed(Duration(milliseconds: 0));
                    },
                    child: Row(
                      children: [
                        CategorySection(
                          height: height,
                          width: width,
                          allCategoryController: allCategoryController,
                          pageController: pageController,
                          putPageController: putPageController,
                          scrollController: scrollController,
                        ),
                        ProductSection(
                          allCategoryController: allCategoryController,
                          height: height,
                          pageController: pageController,
                          putPageController: putPageController,
                          scrollController: scrollController,
                          width: width,
                        ),
                      ],
                    ),
                  ),
                  productController.isLoading2.value
                      ? Container(
                          height: height,
                          width: width,
                          color: AppColors.greyTextColor.withOpacity(0.1),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomLoadingForBerbene(),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
      ),
    );
  }
}
