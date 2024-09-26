import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import '../../controllers/login_controller.dart';
import '../../utils/widgets/my_button.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController getXController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: MyColor.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Get Started',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: MyColor.primaryDarkColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Millions of people use to turn their ideas into reality.",
              style: TextStyle(
                color: MyColor.darkGreyColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 30),
            myButton(
              context: context,
              onTap: () {},
              btnName: 'Zoodha',
              colorType: 4,
            ),
            const SizedBox(height: 20),
            myButton(
              context: context,
              onTap: () {},
              btnName: 'Grrow',
              colorType: 4,
            ),
            const SizedBox(height: 30),
            myButton(
              context: context,
              onTap: getXController.ConnectNow,
              btnName: 'Connect Now',
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => Checkbox(
                    value: getXController.isChecked.value,
                    onChanged: (value) {
                      getXController.toggleCheckbox();
                    },
                  ),
                ),
                const Text("Don't ask again",style:TextStyle( color: MyColor.darkGreyColor,)),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    // Handle skip action
                  },
                  child: const Text(
                    'Skip?',
                    style: TextStyle(
                      color: MyColor.primaryColor,
                    fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
