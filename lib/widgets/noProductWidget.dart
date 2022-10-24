import 'package:berbene_app/flow/utils/capitilizeExtention.dart';
import 'package:berbene_app/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NoProductsWidget extends StatelessWidget {
  final String? categoryTitle;
  const NoProductsWidget({Key? key, this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    categoryTitle!.capitalizeFirstofEach,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.height * 0.019
                          : MediaQuery.of(context).size.height * 0.015,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                    'no_data',
                  ).tr(),
                )),
          ),
        ],
      ),
    );
  }
}
