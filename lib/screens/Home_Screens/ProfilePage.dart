import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/controllers/homescreen_controller.dart';
import 'package:rate_my_portfolio/models/responce/get_signIn_responce.dart';
import 'package:rate_my_portfolio/screens/Home_Screens/profileListingDetailspage.dart';
import '../../controllers/login_controller.dart';
import '../../models/responce/post_PortfolioListing_responce.dart';
import '../../resources/my_assets.dart';
import '../../resources/my_colors.dart';
import '../../utils/my_global.dart';
import '../../utils/widgets/my_button.dart';
import '../starting_screens/GetStarted_Screen.dart';

class PortfolioProfilePage extends StatefulWidget {
  const PortfolioProfilePage({super.key});

  @override
  State<PortfolioProfilePage> createState() => _PortfolioProfilePageState();
}

class _PortfolioProfilePageState extends State<PortfolioProfilePage> {
  final HomeScreenController controller = Get.put(HomeScreenController());
  final LoginController getxcontroller = Get.put(LoginController());

  @override
  void initState() {
    Getdata();
    // TODO: implement initState
    super.initState();
    setState(() {
      Image.network(controller.profileImg);
    });
  }

  Getdata() async {
    await controller.getPortfolioProfileViewData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryLightColor,
      appBar: AppBar(
        leadingWidth: Get.width * 0.3,
        leading: Container(
          margin: const EdgeInsets.only(left: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Back(),
              SizedBox(width: 3),
              controller.profileImg.isEmpty
                  ? ClipOval(
                child: Image(image: portfolioprofileLogo,fit: BoxFit.cover,height: Get.height * 0.05,width:  Get.height * 0.05,),
              )
                  : ClipOval(
                child: Image.network(controller.profileImg,fit: BoxFit.cover,height: Get.height * 0.05,width:  Get.height * 0.05,),
              ),
            ],
          ),
        ),
        title: Text(
          'My portfolio',
          style: TextStyle(
            color: MyColor.primaryDarkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 5.0, top: 5),
              child: Column(
                children: [
                  Icon(Icons.sync, color: MyColor.primaryDarkColor),
                  Text(
                    'Sync',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: MyColor.primaryDarkColor,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Get.to(() => GetStartedScreen("profile"))!.then((value) => Getdata());
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Your Portfolio',
          //     style: TextStyle(
          //       fontSize: 17,
          //       fontWeight: FontWeight.bold,
          //       color: MyColor.primaryColor,
          //     ),
          //   ),
          // ),
          controller.holdingsList.isNotEmpty
              ? Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: controller.holdingsList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.3,
                          child: Text(
                            controller.holdingsList[index].tradingsymbol!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyColor.primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Avg. value : ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: MyColor.darkGreyColor,
                                        ),
                                      ),
                                      Text(
                                        controller.holdingsList[index].averageprice!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: MyColor.textGreyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Unrealized : ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: MyColor.darkGreyColor,
                                        ),
                                      ),
                                      Text(
                                        " ${((double.tryParse(controller.holdingsList[index].ltp!) ?? 0) < (double.tryParse(controller.holdingsList[index].averageprice!) ?? 0)) ? "" : "+"}" +
                                            controller.holdingsList[index].pnlpercentage!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ((double.tryParse(controller.holdingsList[index].ltp!) ?? 0) < (double.tryParse(controller.holdingsList[index].averageprice!) ?? 0)) ? Colors.red.shade800 : MyColor.PortfolioPercentagecolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Realized Going',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "₹ " + ((double.tryParse(controller.holdingsList[index].realisedquantity!) ?? 0) * (double.tryParse(controller.holdingsList[index].ltp!) ?? 0)).toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: MyColor.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
              : Center(
            child: Text(
              'No Holdings Found!',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: MyColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
