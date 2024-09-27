import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/screens/Home_Screens/portfolio_ProfilePage.dart';
import 'package:rate_my_portfolio/screens/starting_screens/SignIn_screen.dart';
import 'package:rate_my_portfolio/screens/starting_screens/splash_screen.dart';
import 'package:rate_my_portfolio/utils/local_database/shdf.dart';

import '../../controllers/homescreen_controller.dart';
import '../../resources/my_assets.dart';
import '../../resources/my_assets.dart';

class PortfolioListingPage extends StatefulWidget {
  @override
  _PortfolioListingPageState createState() => _PortfolioListingPageState();
}

class _PortfolioListingPageState extends State<PortfolioListingPage> {
  final HomeScreenController portfolioController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Get.to(() => PortfolioProfilePage());
            },
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.greenAccent,
              child: Image(image: portfolioprofileLogo),
            ),
          ),
        ),
        title: Text(
          'Portfolio Listing',
          style: TextStyle(
            color: MyColor.primaryDarkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 6),
            child: IconButton(
              icon: Image(
                image: portfolioSliderLogo,
                width: 22,
                height: 22,
              ),
              onPressed: () {
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text("Do You Want To Logout",style: TextStyle(color: Colors.black,fontSize: 18),),
                        ),
                        SizedBox(height: 5,),
                        MaterialButton(
                          color: MyColor.primaryDarkColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                           await SHDFClass.clearPreference();
                           Get.offAll(()=>SignInScreen());
                        },
                        child: Text("Logout"),)
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (portfolioController.portfolios.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: portfolioController.portfolios.length,
          itemBuilder: (context, index) {
            final portfolio = portfolioController.portfolios[index];
            return _buildPortfolioCard(
              username: portfolio.username,
              profileName: portfolio.profileName,
              performanceMetricsLeft: portfolio.performanceMetricsLeft,
              performanceMetricsRight: portfolio.performanceMetricsRight,
              boughtStocks: portfolio.boughtStocks,
              soldStocks: portfolio.soldStocks,
              isPremium: portfolio.isPremium,
            );
          },
        );
      }),
    );
  }

  Widget _buildPortfolioCard({
    required String username,
    required String profileName,
    required String performanceMetricsLeft,
    required String performanceMetricsRight,
    required List<String> boughtStocks,
    required List<String> soldStocks,
    required bool isPremium,
  }) {
    return Card(
      color:Color(0xffFFFFFF),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
      ),
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Image(image: portfolioprofileLogo),
            ),
            title: Text(
              '$username',
              style: TextStyle(color:MyColor.primaryDarkColor, fontWeight: FontWeight.bold),
            ),
            trailing: isPremium
                ? GestureDetector(
              onTap: () {
                showPremiumDialog(context);
              },
              child: Image(image: portfolioCrownLogo, width: 20, height: 20),
            )
                : null,
          ),
          Divider(
            color: MyColor.whiteGreyColor,
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile name:',
                      style: TextStyle(
                        color:MyColor.textGreyColor,
                      ),
                    ),
                    Text(
                      profileName,
                      style: TextStyle(color:MyColor.darkGreyColor,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s...',
                  style: TextStyle(color: MyColor.textGreyColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Performance Metrics',
                      style: TextStyle(color: MyColor.textGreyColor),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      '1,00,000',
                      style: TextStyle(color:MyColor.darkGreyColor,fontWeight: FontWeight.bold)
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'Performance Metrics',
                      style: TextStyle(color: MyColor.textGreyColor),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'Test 3',
                      style: TextStyle(color:MyColor.darkGreyColor,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Performance Metrics',
                      style: TextStyle(color: MyColor.textGreyColor),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'Test 2',
                      style: TextStyle(color:MyColor.darkGreyColor,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'Performance Metrics',
                      style: TextStyle(color: MyColor.textGreyColor),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'Test 4',
                      style: TextStyle(color:MyColor.darkGreyColor,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Premium Indicator',
                      style: TextStyle(
                        color: MyColor.primaryDarkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Divider(
                  color: MyColor.whiteGreyColor,
                  thickness: 1.0,
                ),
                SizedBox(height: 10),

                buildPremiumListItem(
                  'Portfolios above a certain site should be monetized',
                ),
                buildPremiumListItem(
                  'The Portfolio constituency can only be viewed by premium members',
                ),
                buildPremiumListItem(
                  'The registered financial advisor can be requested to review your portfolio.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPremiumListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Image(image: PreminumIndicatorLogo, width: 20, height: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: MyColor.previewIndicatorColor),
            ),
          ),
        ],
      ),
    );
  }
}
