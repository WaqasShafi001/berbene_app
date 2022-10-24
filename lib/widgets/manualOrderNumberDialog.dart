// import 'package:berbene_app/style/appColors.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:get/get.dart';

// class ManualOrderDialog extends StatelessWidget {
//   final Function()? callback;
//   final TextEditingController? orderNumberController;
//   const ManualOrderDialog({Key? key, this.callback, this.orderNumberController})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//         ),
//         backgroundColor: AppColors.whiteColor,
//         elevation: 10,
//         content: Container(
//           height: constraints.maxHeight * 0.1,
//           width: constraints.maxWidth,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: constraints.maxWidth * 0.6,
//                     child: TextFormField(
//                       controller: orderNumberController,
//                       cursorColor: AppColors.mainGreenColor,
//                       style: TextStyle(
//                         color: AppColors.mainGreenColor,
//                       ),
//                       decoration: InputDecoration(
//                         labelText: tr("enter_order_number"),
//                         labelStyle: TextStyle(
//                           color: AppColors.mainGreenColor,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25)),
//                           borderSide: BorderSide(
//                               width: 1, color: AppColors.mainGreenColor),
//                         ),
//                         fillColor: Colors.white,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: AppColors.mainGreenColor, width: 2.0),
//                           borderRadius: BorderRadius.circular(25.0),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         actionsAlignment: MainAxisAlignment.center,
//         actions: [
//           MaterialButton(
//             onPressed: () {
//               if (orderNumberController!.text.isEmpty) {
//                 Get.snackbar('Error', 'Please enter the order number');
//               } else {
//                 Navigator.of(context).pop();
//                 callback!();
//               }
//             },
//             color: AppColors.mainGreenColor,
//             height: constraints.maxHeight * 0.04,
//             minWidth: constraints.maxWidth * 0.32,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             child: Text(
//               'submit',
//               style: TextStyle(
//                 fontSize: constraints.maxHeight * 0.023,
//                 color: AppColors.whiteColor,
//               ),
//             ).tr(),
//           ),
//         ],
//       ),
//     );
//   }
// }
