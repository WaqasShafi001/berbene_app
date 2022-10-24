// ignore_for_file: file_names, prefer_const_constructors

import 'package:berbene_app/flow/utils/capitilizeExtention.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeFoofItem extends StatelessWidget {
  final int? index;
  final String? productImage;
  final String? titleText;
  final Function()? onTap;

  const HomeFoofItem(
      {Key? key,
      this.index,
      required this.productImage,
      required this.titleText,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        elevation: 3,
        child: Container(
          height: height * 0.18,
          width: width * 0.2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                  flex: 7,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        child: CachedNetworkImage(
                          imageUrl: productImage ?? '',
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                              'assets/no_image.png',
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/no_image.png',
                          ),
                          width: width,
                          height: height,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          // height: height * 0.025,
                          // width: width * 0.1,
                          color: AppColors.greyTextColor.withOpacity(0.2),
                          child: Image.asset(
                            'assets/watermark.png',
                            height: height * 0.025,
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.3),
                    child: Center(
                      child: Text(titleText!.capitalizeFirstofEach,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: height * 0.0165))
                          .tr(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
