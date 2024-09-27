import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
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
  final LoginController controller = Get.put(LoginController());


  @override
  void initState() {
    Getdata();
    // TODO: implement initState
    super.initState();
  }


  Getdata() async {
   await controller.getPortfolioProfileViewData();
   setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Get.width * 0.3,
        leading: Container(
          margin: const EdgeInsets.only(left: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 3,),
              Back(),
              SizedBox(width: 3,),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.greenAccent,
                  child: Image(image: portfolioprofileLogo),
                ),
              ),
            ],
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: MyColor.primaryDarkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            color: MyColor.primaryDarkColor,
            onPressed: () {
             Get.to(()=>GetStartedScreen());
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Portfolio',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyColor.darkGreyColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Reliance',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: MyColor.primaryColor,
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                decoration: BoxDecoration(
                                  color: MyColor.whiteGreyColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: MyColor.whiteGreyColor, width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Avg. value:',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: MyColor.darkGreyColor,
                                            ),
                                          ),
                                          Text(
                                            ' 1000',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: MyColor.textGreyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            'Unrealized:',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: MyColor.darkGreyColor,
                                            ),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            ' +53%',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: MyColor.PortfolioPercentagecolor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Realized Going',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '₹4,995.99',
                              style: TextStyle(
                                fontSize: 16,
                                color: MyColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: myButton(
              context: context,
              onTap: () {},
              btnName: 'Request Review from F4',
            ),
          ),
        ],
      ),
    );
  }
}
