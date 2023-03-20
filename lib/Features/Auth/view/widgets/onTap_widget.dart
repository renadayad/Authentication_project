import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Common/utils/theme.dart';
import '../../logic/controller/auth_controller.dart';

class TabWidget extends StatelessWidget {
  Widget firstTap;
  Widget secandTap;
  double height;
  final controller = Get.find<AuthController>();
  TabWidget(
      {super.key,
      required this.firstTap,
      required this.secandTap,
      required this.height});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 40,
              child: TabBar(
                onTap: (value) {
                  controller.clearController();
                },
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: mainColor,
                tabs: const [
                  Tab(
                    child: Text(
                      'Email',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Phone number',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height,
              child: TabBarView(children: [
                firstTap,
                secandTap,
              ]),
            ),
          ],
        ));
  }
}
