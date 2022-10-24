import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Tab2_innformation extends StatelessWidget {
  final String? texts;

  const Tab2_innformation({
    Key? key,
    required this.width,
    required this.height,
    this.texts,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.025, vertical: height * 0.02),
          child: Html(data: texts)),
    );
  }
}

class Tab1_ingredients extends StatelessWidget {
  final String? texts;
  const Tab1_ingredients({
    Key? key,
    required this.width,
    required this.height,
    this.texts,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.025, vertical: height * 0.02),
          child: Html(data: texts)),
    );
  }
}
