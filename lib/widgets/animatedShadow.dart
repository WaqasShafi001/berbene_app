// ignore_for_file: file_names

import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';

class ImageTransition extends AnimatedWidget {
  final String? imageUrl;

  Animation<double> get shadowXOffset => listenable as Animation<double>;
  const ImageTransition(this.imageUrl, {shadowXOffset})
      : super(listenable: shadowXOffset);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: AppColors.mainGreenColor.withOpacity(0.6),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(shadowXOffset.value, 20.0),
              color: AppColors.mainGreenColor.withOpacity(0.9),
              spreadRadius: -10,
            )
          ],
        ),
        child: Image.asset(
          imageUrl!,
          filterQuality: FilterQuality.high,
         
        ),
      ),
    );
  }
}
