import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/utils/my_global.dart';
import '../../controllers/homescreen_controller.dart';
import '../../utils/widgets/my_button.dart';

class SelectPlanPricePage extends StatefulWidget {
  const SelectPlanPricePage({super.key});

  @override
  State<SelectPlanPricePage> createState() => _SelectPlanPricePageState();
}

class _SelectPlanPricePageState extends State<SelectPlanPricePage> {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false ,
        leading: Back(),
        title: Text('Select Your Plan',
            style: TextStyle(
                color: MyColor.primaryDarkColor,
                fontWeight: FontWeight.bold)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 10),
              Padding(
                padding:  EdgeInsets.only(left: 8.0),
                child: Text(
                  'We believe in flexibility and affordability, which is why we\'ve designed a range of pricing plans for our online survey and newsletter creation services.',
                  style: TextStyle(fontSize: 13, color: MyColor.matricsgreyColor),
                ),
              ),
               SizedBox(height: 20),
              // buildPlanCard(
              //   context,
              //   'Standard',
              //   'Start for free, no credit card needed.',
              //   'FREE',
              //   MyColor.PricefreeYelloowColor,
              //   'Continue with Free',
              //   onSelect: () => controller.selectPlan('Standard'),
              // ),
              //  SizedBox(height: 16),
              buildPlanCard(
                context,
                'Professional',
                'Unlock the full capabilities of "company" and enjoy new perks as they are added.',
                '₹499',
                Colors.blue,
                'Continue with Pro',
                onSelect: () => {},
              ),
               SizedBox(height: 16),
              buildPlanCard(
                context,
                'Elite',
                'All coverage included in the Pro offer, Suspensions, bearing and radiators.',
                '₹999',
                Colors.blue,
                'Continue with Pro',
                onSelect: () => {},
              ),
               SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlanCard(
      BuildContext context,
      String title,
      String description,
      String price,
      Color priceColor,
      String buttonText, {
        required VoidCallback onSelect,
      }) {
    return Obx(() {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: controller.selectedPlan.value == title
                          ? MyColor.primaryColor
                          : MyColor.selectPlanColor,
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: priceColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      price,
                      style: TextStyle(
                        color: priceColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: MyColor.matricsgreyColor),
              ),
               SizedBox(height: 16),
              buttonText == 'Continue with Free'
                  ? Container(
                width: MediaQuery.of(context).size.width,
                height: Get.height * 0.07,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xD6EEEBF5),
                      Color(0xD3DEEDF5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: onSelect,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: MyColor.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
                  : myButton(
                context: context,
                onTap: onSelect,
                btnName: buttonText,
                colorType: controller.selectedPlan.value == title ? 1 : 0,
                buttonColor: controller.selectedPlan.value == title
                    ? MyColor.primaryColor
                    : MyColor.primaryColor,
              ),
            ],
          ),
        ),
      );
    });
  }

}
