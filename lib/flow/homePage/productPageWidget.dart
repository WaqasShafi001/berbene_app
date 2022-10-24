import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/flow/homePage/homePageCategories.dart';
import 'package:berbene_app/flow/utils/capitilizeExtention.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../apiModels/allCategoryApiModel.dart';
import '../../main.dart';
import '../productDetailScreen.dart';

class ProductsPageForPageView extends StatefulWidget {
  final CategoriesApiController? allCategoryController;
  final String? categoryTitle;
  final int? indexForCategory;

  ProductsPageForPageView(
      {this.allCategoryController, this.indexForCategory, this.categoryTitle});

  @override
  State<ProductsPageForPageView> createState() =>
      _ProductsPageForPageViewState();
}

class _ProductsPageForPageViewState extends State<ProductsPageForPageView> {
  var _scrollController = ScrollController();
  List<String?>? thumbnails;

  @override
  void initState() {
    thumbnails = widget.allCategoryController!
        .categoriesList[widget.indexForCategory!].products!
        .map((e) => e.thumbnail)
        .toList();

    super.initState();
  }

  var formatter = NumberFormat('#,##,000');

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;

    return Obx(
      () => Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
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
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                      child: Text(
                        '${widget.categoryTitle!.capitalizeFirstofEach}',
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
              widget
                      .allCategoryController!
                      .categoriesList[widget.indexForCategory!]
                      .products!
                      .isEmpty
                  ? Expanded(
                      child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              'no_data',
                            ).tr(),
                          )),
                    )
                  : Expanded(
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.01),
                          child: GridView.builder(
                            shrinkWrap: false,
                            controller: _scrollController,
                            itemCount: widget
                                .allCategoryController!
                                .categoriesList[widget.indexForCategory!]
                                .products!
                                .length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing:
                                        MediaQuery.of(context).size.width > 600
                                            ? 6
                                            : 0.0,
                                    mainAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              if (thumbnails != null) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      ProductDetailScreen(
                                        title: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .title,
                                        titleAr: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .titleAr,
                                        price: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .price,
                                        ingredients: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .ingredients,
                                        nutritionAr: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .ingredientsAr,
                                        nutrition: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .nutritionInfo,
                                        ingredientsAr: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .nutritionInfoAr,
                                        sliderImages: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .images!
                                            .map((e) => e.url)
                                            .toList(),
                                        trasnlationID: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .translationId,
                                                isHalal: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .halal,
                                        isChilli: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .chilli,
                                        isPopular: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .popular,
                                        isVegiterian: widget
                                            .allCategoryController!
                                            .categoriesList[
                                                widget.indexForCategory!]
                                            .products![index]
                                            .vageterian,
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: thumbnails![index]!
                                              .replaceAll(' ', '%20')
                                              .trim(),
                                          placeholder: (context, url) => Center(
                                            child: Image.asset(
                                              'assets/no_image.png',
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/no_image.png',
                                          ),
                                          fit: BoxFit.fill,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? height * 0.135
                                              : height * 0.105,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.005,
                                        ),
                                        Text(
                                          findLanguageController.isEnglish.value
                                              ? widget
                                                  .allCategoryController!
                                                  .categoriesList[
                                                      widget.indexForCategory!]
                                                  .products![index]
                                                  .title!
                                                  .capitalizeFirstofEach
                                              : widget
                                                  .allCategoryController!
                                                  .categoriesList[
                                                      widget.indexForCategory!]
                                                  .products![index]
                                                  .titleAr!
                                                  .capitalizeFirstofEach,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016,
                                              fontWeight: FontWeight.w600),
                                        ).tr(),
                                        Text(
                                          '${formatter.format(widget.allCategoryController!.categoriesList[widget.indexForCategory!].products![index].price)} IQD',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}
