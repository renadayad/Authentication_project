// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../Features/Auth/logic/controller/auth_controller.dart';
// import '../../../Core/routes/routes.dart';
// import '../../../Common/widgets/text_utils.dart';
// import '../../../Common/utils/theme.dart';
//
// class CheckWidget extends StatelessWidget {
//   CheckWidget({super.key});
//   final controller = Get.find<AuthController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (_) {
//       return Row(
//         children: [
//           InkWell(
//             onTap: () {
//               controller.CheckBox();
//             },
//             child: Container(
//               height: 2.11.h,
//               width: 4.58.w,
//               decoration: BoxDecoration(
//                   color: labalColor, borderRadius: BorderRadius.circular(4)),
//               child: controller.isCheckBox
//                   ? Icon(
//                       Icons.done,
//                       size: 15,
//                       color: Colors.white,
//                     )
//                   : Icon(
//                       Icons.crop_square_rounded,
//                       size: 15,
//                       color: Colors.white,
//                     ),
//             ),
//           ),
//           SizedBox(
//             width: 2.54.w,
//           ),
//           TextUtils(
//             text: "Remember me ",
//             color: labalColor,
//             fontWeight: FontWeight.normal,
//             fontsize: 9.sp,
//           ),
//           SizedBox(
//             width: 3.05.w,
//           ),
//           Row(
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: TextButton(
//                   onPressed: (() {
//                     Get.toNamed(Routes.forgotpasswordScreen);
//                   }),
//                   child: TextUtils(
//                       text: "Don't remember the password? ",
//                       color: labalColor,
//                       fontWeight: FontWeight.normal,
//                       fontsize: 7.sp,
//                       underLine: TextDecoration.underline),
//                 ),
//               )
//             ],
//           )
//         ],
//       );
//     });
//   }
// }
