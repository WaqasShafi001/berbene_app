import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/flow/utils/capitilizeExtention.dart';
import 'package:berbene_app/main.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../productDetailScreen.dart';
import 'homePageCategories.dart';

class SubCategoriesPageForProducts extends StatefulWidget {
  final CategoriesApiController? allCategoryController;
  final int? indexForCategory;

  const SubCategoriesPageForProducts({
    Key? key,
    this.allCategoryController,
    this.indexForCategory,
  }) : super(key: key);

  @override
  State<SubCategoriesPageForProducts> createState() =>
      _SubCategoriesPageForProductsState();
}

class _SubCategoriesPageForProductsState
    extends State<SubCategoriesPageForProducts> {
  var listScrollController = ScrollController();

  @override
  void dispose() {
    listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height,
      child: ListView.builder(
        controller: listScrollController,
        itemBuilder: (context, index) {
          return ExpandableCard(
            indexForCategory: widget.indexForCategory,
            indexForSubCategory: index,
            allCategoryController: widget.allCategoryController,
          );
        },
        itemCount: widget.allCategoryController!
            .categoriesList[widget.indexForCategory!].subcategory!.length,
      ),
    );
  }
}

class ExpandableCard extends StatefulWidget {
  final CategoriesApiController? allCategoryController;
  final int? indexForCategory;
  final int? indexForSubCategory;

  const ExpandableCard({
    Key? key,
    this.allCategoryController,
    this.indexForCategory,
    this.indexForSubCategory,
  }) : super(key: key);

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  var scrollController = ScrollController();

  var formatter = NumberFormat('#,##,000');

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Card(
        elevation: 0,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.005),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.mainGreenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      findLanguageController.isEnglish.value
                          ? '${widget.allCategoryController!.categoriesList[widget.indexForCategory!].subcategory![widget.indexForSubCategory!].title!.capitalizeFirstofEach}'
                          : '${widget.allCategoryController!.categoriesList[widget.indexForCategory!].subcategory![widget.indexForSubCategory!].titleAr!.capitalizeFirstofEach}',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.height * 0.018
                            : MediaQuery.of(context).size.height * 0.015,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            innerProductsGrid(height: height, width: width),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ],
        ),
      ),
    ));
  }

  Widget DummyProduct(
      {String? imageURL, String? productName, int? productPrice}) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageURL!.replaceAll(' ', '%20').trim(),
            placeholder: (context, url) => Center(
              child: Image.asset(
                'assets/no_image.png',
              ),
            ),
            errorWidget: (context, url, error) => Center(
              child: Image.asset(
                'assets/no_image.png',
              ),
            ),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.height * 0.135
                : MediaQuery.of(context).size.height * 0.105,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Text(
            productName!.capitalizeFirstofEach,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '${formatter.format(productPrice)} IQD',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
          ),
        ],
      ),
    );
  }

  outerListProducts({
    double? height,
    double? width,
  }) {
    return widget
            .allCategoryController!
            .categoriesList[widget.indexForCategory!]
            .subcategory![widget.indexForSubCategory!]
            .products!
            .isEmpty
        ? Center(child: Text('no_data').tr())
        : Container(
            height: MediaQuery.of(context).size.width > 600
                ? height! * 0.2
                : height! * 0.16,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing:
                      MediaQuery.of(context).size.width > 600 ? 6 : 0.0,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(ProductDetailScreen(
                    title: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .title,
                    titleAr: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .titleAr,
                    price: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .price,
                    ingredients: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .ingredients,
                    ingredientsAr: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .ingredientsAr,
                    nutrition: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .nutritionInfo,
                    nutritionAr: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .nutritionInfoAr,
                    trasnlationID: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .translationId,
                    sliderImages: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .images!
                        .map((e) => e.url)
                        .toList(),
                             isHalal: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .halal,
                    isChilli: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .chilli,
                    isPopular: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .popular,
                    isVegiterian: widget
                        .allCategoryController!
                        .categoriesList[widget.indexForCategory!]
                        .subcategory![widget.indexForSubCategory!]
                        .products![index]
                        .vageterian,
                  ));
                },
                child: DummyProduct(
                  imageURL: widget
                      .allCategoryController!
                      .categoriesList[widget.indexForCategory!]
                      .subcategory![widget.indexForSubCategory!]
                      .products![index]
                      .thumbnail,
                  productName: findLanguageController.isEnglish.value
                      ? widget
                          .allCategoryController!
                          .categoriesList[widget.indexForCategory!]
                          .subcategory![widget.indexForSubCategory!]
                          .products![index]
                          .title
                      : widget
                          .allCategoryController!
                          .categoriesList[widget.indexForCategory!]
                          .subcategory![widget.indexForSubCategory!]
                          .products![index]
                          .titleAr,
                  productPrice: widget
                      .allCategoryController!
                      .categoriesList[widget.indexForCategory!]
                      .subcategory![widget.indexForSubCategory!]
                      .products![index]
                      .price,
                ),
              ),
              itemCount: widget
                          .allCategoryController!
                          .categoriesList[widget.indexForCategory!]
                          .subcategory![widget.indexForSubCategory!]
                          .products!
                          .length >
                      2
                  ? 2
                  : widget
                              .allCategoryController!
                              .categoriesList[widget.indexForCategory!]
                              .subcategory![widget.indexForSubCategory!]
                              .products!
                              .length <
                          1
                      ? 0
                      : widget
                          .allCategoryController!
                          .categoriesList[widget.indexForCategory!]
                          .subcategory![widget.indexForSubCategory!]
                          .products!
                          .length,
              shrinkWrap: false,
              physics: NeverScrollableScrollPhysics(),
            ),
          );
  }

  innerProductsGrid({
    double? height,
    double? width,
  }) {
    return widget
            .allCategoryController!
            .categoriesList[widget.indexForCategory!]
            .subcategory![widget.indexForSubCategory!]
            .products!
            .isEmpty
        ? Center(child: Text('no_data').tr())
        : SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing:
                          MediaQuery.of(context).size.width > 600 ? 6 : 0.0,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Get.to(ProductDetailScreen(
                        title: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .title,
                        titleAr: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .titleAr,
                        price: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .price,
                        ingredients: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .ingredients,
                        ingredientsAr: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .ingredientsAr,
                        nutrition: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .nutritionInfo,
                        nutritionAr: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .nutritionInfoAr,
                        trasnlationID: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .translationId,
                        sliderImages: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .images!
                            .map((e) => e.url)
                            .toList(),
                              isHalal: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .halal,
                        isChilli: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .chilli,
                        isPopular: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .popular,
                        isVegiterian: widget
                            .allCategoryController!
                            .categoriesList[widget.indexForCategory!]
                            .subcategory![widget.indexForSubCategory!]
                            .products![index]
                            .vageterian,
                      ));
                    },
                    child: DummyProduct(
                      imageURL: widget
                          .allCategoryController!
                          .categoriesList[widget.indexForCategory!]
                          .subcategory![widget.indexForSubCategory!]
                          .products![index]
                          .thumbnail,
                      productName: findLanguageController.isEnglish.value
                          ? widget
                              .allCategoryController!
                              .categoriesList[widget.indexForCategory!]
                              .subcategory![widget.indexForSubCategory!]
                              .products![index]
                              .title
                          : widget
                              .allCategoryController!
                              .categoriesList[widget.indexForCategory!]
                              .subcategory![widget.indexForSubCategory!]
                              .products![index]
                              .titleAr,
                      productPrice: widget
                          .allCategoryController!
                          .categoriesList[widget.indexForCategory!]
                          .subcategory![widget.indexForSubCategory!]
                          .products![index]
                          .price,
                    ),
                  ),
                  itemCount: widget
                      .allCategoryController!
                      .categoriesList[widget.indexForCategory!]
                      .subcategory![widget.indexForSubCategory!]
                      .products!
                      .length,
                  controller: scrollController,
                ),
              ],
            ),
          );
  }
}
