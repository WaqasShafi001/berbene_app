import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/controllers/categoryPageController.dart';
import 'package:berbene_app/flow/homePage/productPageWidget.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../main.dart';
import 'productsForSubcategories.dart';

class ProductSection extends StatefulWidget {
  final double? height;
  final double? width;
  final ItemScrollController? scrollController;
  final GetPageController? putPageController;
  final CategoriesApiController? allCategoryController;
  final PageController? pageController;

  const ProductSection({
    Key? key,
    this.scrollController,
    this.putPageController,
    this.allCategoryController,
    this.pageController,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          widget.putPageController!.selectedIndex.value = value;
          widget.scrollController!.scrollTo(
            index: value,
            alignment: value == 0
                ? 0.0
                : value == 1
                    ? 0.15
                    : value == 2
                        ? 0.25
                        : value ==
                                widget.allCategoryController!.categoriesList
                                        .indexOf(widget.allCategoryController!
                                            .categoriesList.last) -
                                    1
                            ? 0.55
                            : value ==
                                    widget.allCategoryController!.categoriesList
                                        .indexOf(widget.allCategoryController!
                                            .categoriesList.last)
                                ? 0.7
                                : 0.4,
            curve: Curves.linear,
            duration: Duration(
              milliseconds: 700,
            ),
          );
        },
        controller: widget.pageController,
        itemBuilder: (context, index) {
          return widget.allCategoryController!.categoriesList[index]
                  .subcategory!.isNotEmpty
              ? SubCategoriesPageForProducts(
                  allCategoryController: widget.allCategoryController,
                  indexForCategory: index,
                )
              : ProductsPageForPageView(
                  allCategoryController: widget.allCategoryController,
                  categoryTitle: findLanguageController.isEnglish.value
                      ? widget
                          .allCategoryController!.categoriesList[index].title
                      : widget
                          .allCategoryController!.categoriesList[index].titleAr,
                  indexForCategory: index,
                );
        },
        scrollDirection: Axis.vertical,
        itemCount: widget.allCategoryController!.categoriesList.length,
      ),
    );
  }
}
