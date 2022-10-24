import 'package:avatar_view/avatar_view.dart';
import 'package:berbene_app/controllers/categoryApiController.dart';
import 'package:berbene_app/controllers/categoryPageController.dart';
import 'package:berbene_app/flow/utils/capitilizeExtention.dart';
import 'package:berbene_app/flow/utils/sizeConfig.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../main.dart';

class CategorySection extends StatefulWidget {
  final double? height;
  final double? width;
  final CategoriesApiController? allCategoryController;
  final ItemScrollController? scrollController;
  final PageController? pageController;
  final GetPageController? putPageController;
  const CategorySection({
    Key? key,
    this.height,
    this.width,
    this.allCategoryController,
    this.scrollController,
    this.pageController,
    this.putPageController,
  }) : super(key: key);

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      color: AppColors.whiteColor,
      width: widget.width! * 0.3,
      height: widget.height,
      child: ScrollablePositionedList.builder(
          itemCount: widget.allCategoryController!.categoriesList.length + 1,
          shrinkWrap: true,
          itemScrollController: widget.scrollController,
          initialAlignment: 0,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == widget.allCategoryController!.categoriesList.length) {
              return InkWell(
                onTap: () {
                  widget.scrollController!.jumpTo(index: 0, alignment: 0.0);

                  widget.pageController!.animateToPage(0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.height! * 0.01,
                  ),
                  child: Container(
                    height: widget.height! * 0.12,
                    width: widget.width,
                    color: AppColors.mainGreenColor.withOpacity(0.5),
                    child: Padding(
                      padding: EdgeInsets.all(widget.height! * 0.025),
                      child: CircleAvatar(
                        backgroundColor: AppColors.whiteColor,
                        child: Icon(
                          Icons.arrow_upward_sharp,
                          color: AppColors.mainGreenColor,
                          size: widget.height! * 0.03,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return InkWell(
              onTap: () {
                widget.scrollController!.scrollTo(
                    index: widget.putPageController!.selectedIndex.value,
                    curve: Curves.linear,
                    alignment: index == 0
                        ? 0.0
                        : index == 1
                            ? 0.12
                            : index == 2
                                ? 0.24
                                : index ==
                                        widget.allCategoryController!
                                                .categoriesList
                                                .indexOf(widget
                                                    .allCategoryController!
                                                    .categoriesList
                                                    .last) -
                                            1
                                    ? 0.6
                                    : index ==
                                            widget.allCategoryController!
                                                .categoriesList
                                                .indexOf(widget
                                                    .allCategoryController!
                                                    .categoriesList
                                                    .last)
                                        ? 0.7
                                        : 0.5,
                    duration: Duration(milliseconds: 700));
                widget.putPageController!.selectedIndex.value = index;
                widget.pageController!.jumpToPage(
                  widget.putPageController!.selectedIndex.value,
                );
              },
              child: Obx(() => Padding(
                    padding: MediaQuery.of(context).size.width > 600
                        ? const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4)
                        : const EdgeInsets.all(0.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 700),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.width > 600
                          ? SizeConfig.blockSizeVertical! * 20.9
                          : SizeConfig.blockSizeVertical! * 20.5,
                      width: SizeConfig.blockSizeHorizontal! * 30,
                      color: AppColors.whiteColor,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: Colors.transparent,
                              shadowColor: Colors.black38,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 700),
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.width > 600
                                    ? SizeConfig.blockSizeVertical! * 17
                                    : SizeConfig.blockSizeVertical! * 12.5,
                                decoration: BoxDecoration(
                                  color: widget.putPageController!.selectedIndex
                                              .value ==
                                          index
                                      ? AppColors.selectedCategoryColor
                                      : AppColors.unselectedCategoryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      findLanguageController.isEnglish.value
                                          ? widget
                                              .allCategoryController!
                                              .categoriesList[index]
                                              .title!
                                              .capitalizeFirstofEach
                                          : widget
                                              .allCategoryController!
                                              .categoriesList[index]
                                              .titleAr!
                                              .capitalizeFirstofEach,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0175
                                                : MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.015,
                                      ),
                                    ).tr(),
                                    SizedBox(
                                      height:
                                          SizeConfig.blockSizeVertical! * 0.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.width > 600
                                ? SizeConfig.blockSizeVertical! * 1.8
                                : SizeConfig.blockSizeVertical! * 3.4,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(-1, 2),
                                      blurRadius: 1,
                                      blurStyle: BlurStyle.normal,
                                      spreadRadius: 0.1,
                                      color: Colors.black26,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: AppColors.mainGreenColor,
                                          width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: AvatarView(
                                      radius: MediaQuery.of(context)
                                                  .size
                                                  .width >
                                              600
                                          ? SizeConfig.blockSizeHorizontal! * 11
                                          : SizeConfig.blockSizeHorizontal! *
                                              11.5,
                                      borderColor: AppColors.whiteColor,
                                      borderWidth: 1,
                                      avatarType: AvatarType.CIRCLE,
                                      backgroundColor: AppColors.whiteColor,
                                      imagePath: widget
                                              .allCategoryController!
                                              .categoriesList[index]
                                              .thumbnail ??
                                          '',
                                      placeHolder: Center(
                                        child: Image.asset(
                                          'assets/no_image.png',
                                        ),
                                      ),
                                      errorWidget: Center(
                                        child: Image.asset(
                                          'assets/no_image.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}
