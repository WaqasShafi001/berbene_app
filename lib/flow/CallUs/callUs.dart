// ignore_for_file: file_names, prefer_const_constructors
import 'package:berbene_app/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class CallUs extends StatelessWidget {
  const CallUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        height: height,
        width: width,
        context: context,
      ),
      body: Center(
        child: Text('call us'),
      ),
    );
  }
}
