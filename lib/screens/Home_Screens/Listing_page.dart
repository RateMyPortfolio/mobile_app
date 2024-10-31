import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/screens/Home_Screens/FilterPage.dart';
import 'package:rate_my_portfolio/screens/Home_Screens/ProfilePage.dart';
import 'package:rate_my_portfolio/screens/Home_Screens/profileListingDetailspage.dart';
import '../../controllers/homescreen_controller.dart';
import '../../models/responce/post_PortfolioListing_responce.dart';
import '../../resources/my_assets.dart';
import '../../utils/local_database/shdf.dart';
import '../starting_screens/SignIn_screen.dart';
import 'My_Profile_Info_Page.dart';
import 'SelectPricePlanPage.dart';

class PortfolioListingPage extends StatefulWidget {
  @override
  _PortfolioListingPageState createState() => _PortfolioListingPageState();
}

class _PortfolioListingPageState extends State<PortfolioListingPage> {
  final HomeScreenController portfolioController = Get.put(HomeScreenController());

  @override
  void initState() {
    portfolioController.profileImg;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          child: PopupMenuButton<int>(
            icon: Image(
              image: portfolioMoreLogo,
              color: MyColor.primaryDarkColor,
              width: 22,
              height: 22,
            ),
            onSelected: (int result) {
              if (result == 3) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Text("Do You Want To Logout", style: TextStyle(color: Colors.black, fontSize: 18)),
                          ),
                          SizedBox(height: 5),
                          MaterialButton(
                            color: MyColor.primaryDarkColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed: () async {
                              await SHDFClass.clearPreference();
                              Get.offAll(() => SignInScreen());
                            },
                            child: Text("Logout"),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (result == 2) {
                  Get.to(() => MyProfileInfo());
              } else if (result == 1) {
                Get.to(() => PortfolioProfilePage());
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.menu, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Menu",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.person, color: MyColor.white),
                  title: Text("My Profile"),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.bar_chart_sharp, color: MyColor.white),
                  title: Text("My Portfolio"),
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.logout, color: MyColor.white),
                  title: Text("Logout"),
                ),
              ),
            ],
          ),
        ),
        title: Text(
          "Portfolio Listing",
          style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold),
        ),
        // portfolioController.profileImg.isEmpty
        //     ? CircleAvatar(
        //   radius: 22,
        //   backgroundColor: Colors.greenAccent,
        //   child: Image(image: portfolioprofileLogo),
        // )
        //     : CircleAvatar(
        //   radius: 22,
        //   backgroundColor: Colors.grey.shade200,
        //   child: Image.network(portfolioController.profileImg),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              child: InkWell(
                child: Image(
                  image: portfolioSliderLogo,
                  width: 22,
                  height: 22,
                ),
                onTap: () {
                  Get.to(() => PortFolioFilterPage());
                },
              ),
            ),
          ),

          // IconButton(
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           backgroundColor: Colors.white,
          //           contentPadding: EdgeInsets.all(10),
          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //           content: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Container(
          //                 child: Text("Do You Want To Logout", style: TextStyle(color: Colors.black, fontSize: 18)),
          //               ),
          //               SizedBox(height: 5),
          //               MaterialButton(
          //                 color: MyColor.primaryDarkColor,
          //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //                 onPressed: () async {
          //                   await SHDFClass.clearPreference();
          //                   Get.offAll(() => SignInScreen());
          //                 },
          //                 child: Text("Logout"),
          //               )
          //             ],
          //           ),
          //         );
          //       },
          //     );
          //   },
          //   icon: Icon(
          //     Icons.logout,
          //     color: Colors.red.shade800,
          //   ),
          // ),
        ],
      ),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            setState(() {
              portfolioController.portfolios.length;
              portfolioController.profileImg;
            });
          },
          child: portfolioController.portfolios.isEmpty
              ? Center(
                  child: Text(
                    "No portfolios found",
                    style: TextStyle(
                      color: MyColor.whiteDarkGreyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: portfolioController.portfolios.length,
                  itemBuilder: (context, index) {
                    final portfolio = portfolioController.portfolios[index];
                    return _buildPortfolioCard(portfolio as PortfolioListingpayload);
                  },
                ),
        );
      }),
    );
  }

  // Widget _buildPortfolioCard(PortfolioListingpayload portfolio) {
  //   return InkWell(
  //     onTap: () {
  //       Get.to(() => portfolioProfileDetail(portfolio));
  //       // arguments: {
  //       //   'username': portfolio.username,
  //       //   'portfolioId': portfolio.portfolioId,
  //       //   'profileImg': portfolio.profileImg ??"",
  //       //
  //     },
  //     child: Card(
  //       color: Color(0xffFFFFFF),
  //       margin: const EdgeInsets.symmetric(vertical: 8.0),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
  //       ),
  //       elevation: 2,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           ListTile(
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  //             leading: Stack(
  //               children: [
  //                 CircleAvatar(
  //                   backgroundColor: MyColor.matricsgreyColor,
  //                   backgroundImage: portfolio.profileImg != null && portfolio.profileImg!.isNotEmpty ? NetworkImage(portfolio.profileImg!) : null,
  //                 ),
  //                 if (portfolio.profileImg == null || portfolio.profileImg!.isEmpty)
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color: MyColor.matricsgreyColor,
  //                     ),
  //                     child: ClipOval(
  //                       child: Image(
  //                         image: portfolioprofileLogo,
  //                         fit: BoxFit.cover,
  //                         width: 20,
  //                         height: 20,
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             ),
  //             title: Text(
  //               '${portfolio.username}',
  //               style: TextStyle(
  //                 color: MyColor.primaryDarkColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             trailing: portfolio.isCrown == true
  //                 ? GestureDetector(
  //                     onTap: () {
  //                       showPremiumDialog(context);
  //                     },
  //                     child: Image(image: portfolioCrownLogo, width: 20, height: 20),
  //                   )
  //                 : null,
  //           ),
  //           Divider(
  //             color: MyColor.whiteGreyColor,
  //             thickness: 1.0,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(height: 4),
  //                 // Row(
  //                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 //   children: [
  //                 //     Text(
  //                 //       'Profile name:',
  //                 //       style: TextStyle(color: MyColor.textGreyColor),
  //                 //     ),
  //                 //     Text(
  //                 //       portfolio.selectedBroker ?? "",
  //                 //       style: TextStyle(
  //                 //         color: MyColor.primaryDarkColor,
  //                 //         fontWeight: FontWeight.bold,
  //                 //         fontSize: 13
  //                 //       ),
  //                 //     ),
  //                 //   ],
  //                 // ),
  //                 // SizedBox(height: 8),
  //                 Text(
  //                   portfolio.description ?? "",
  //                   style: TextStyle(color: MyColor.textGreyColor),
  //                 ),
  //                 SizedBox(height: 16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Performance Metrics',
  //                           style: TextStyle(color: MyColor.textGreyColor),
  //                         ),
  //                         SizedBox(height: 4),
  //                         Text(
  //                           portfolio.performaceMetrics1 ?? "",
  //                           style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
  //                         ),
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Performance Metrics',
  //                           style: TextStyle(color: MyColor.textGreyColor),
  //                         ),
  //                         SizedBox(height: 4),
  //                         Text(
  //                           portfolio.performaceMetrics2 ?? "",
  //                           style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 16.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             'Performance Metrics',
  //                             style: TextStyle(color: MyColor.textGreyColor),
  //                           ),
  //                           SizedBox(height: 4),
  //                           Text(
  //                             portfolio.performaceMetrics3 ?? "",
  //                             style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 16.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             'Performance Metrics',
  //                             style: TextStyle(color: MyColor.textGreyColor),
  //                           ),
  //                           SizedBox(height: 4),
  //                           Text(
  //                             portfolio.performaceMetrics4 ?? "",
  //                             style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPortfolioCard(PortfolioListingpayload portfolio) {
    return InkWell(
      onTap: () {
        if(portfolio.isCrown == true){
          Get.to(()=>SelectPlanPricePage());
        }else {
          Get.to(() => portfolioProfileDetail(portfolio));
        }
      },
      child: Card(
        color: Color(0xffFFFFFF),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: MyColor.matricsgreyColor,
                    backgroundImage: portfolio.profileImg != null && portfolio.profileImg!.isNotEmpty
                        ? NetworkImage(portfolio.profileImg!)
                        : null,
                  ),
                  if (portfolio.profileImg == null || portfolio.profileImg!.isEmpty)
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyColor.matricsgreyColor,
                      ),
                      child: ClipOval(
                        child: Image(
                          image: portfolioprofileLogo,
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                '${portfolio.username}',
                style: TextStyle(
                  color: MyColor.primaryDarkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: portfolio.isCrown == true
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
                  if (portfolio.description != null && portfolio.description!.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Text(
                      portfolio.description!,
                      style: TextStyle(color: MyColor.textGreyColor),
                    ),
                    SizedBox(height: 16),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Performance Metrics',
                            style: TextStyle(color: MyColor.textGreyColor),
                          ),
                          SizedBox(height: 4),
                          Text(
                            portfolio.performaceMetrics1 ?? "",
                            style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
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
                          SizedBox(height: 4),
                          Text(
                            portfolio.performaceMetrics2 ?? "",
                            style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Performance Metrics',
                              style: TextStyle(color: MyColor.textGreyColor),
                            ),
                            SizedBox(height: 4),
                            Text(
                              portfolio.performaceMetrics3 ?? "",
                              style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Performance Metrics',
                              style: TextStyle(color: MyColor.textGreyColor),
                            ),
                            SizedBox(height: 4),
                            Text(
                              portfolio.performaceMetrics4 ?? "",
                              style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
