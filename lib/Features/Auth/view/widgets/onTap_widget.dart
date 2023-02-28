import 'package:auth_app/Features/Auth/view/widgets/signUp_email_form.dart';
import 'package:auth_app/Features/Auth/view/widgets/signUp_phone_number_form.dart';
import 'package:flutter/material.dart';
import '../../../../Common/utils/theme.dart';

class TabWidget extends StatelessWidget {
  Widget firstTap;
  Widget secandTap;
  double height;
  TabWidget({super.key, required this.firstTap, required this.secandTap, required this.height});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 40,
              child: const TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: mainColor,
                tabs: [
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

                // SignUp_Email_Form(),
                // SignUp_Phone_Number_Form(),
              ]),
            ),
          ],
        ));
  }
}
