import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/utils/my_global.dart';
import '../../controllers/login_controller.dart';
import '../../utils/local_database/key_constants.dart';
import '../../utils/local_database/shdf.dart';
import '../../utils/widgets/TextFeild.dart';
import '../../utils/widgets/TextFormFeild.dart';
import '../../utils/widgets/coustumTextFeild_btnDesign.dart';
import '../../utils/widgets/my_button.dart';
import '../Home_Screens/portfolio_Listing.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final LoginController getXController = Get.put(LoginController());


  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      setData();
    });
    // TODO: implement initState
    super.initState();
  }

  setData() async {
   getXController.clientIdCtr.text = await SHDFClass.readStringValue(KeyConstants.clientId,"") ?? "";
   getXController.pinCtr.text = await SHDFClass.readStringValue(KeyConstants.pin,"") ?? "";
   getXController.totpCtr.text = await SHDFClass.readStringValue(KeyConstants.totp,"") ?? "";
   setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColor.white,
      appBar: AppBar(
        centerTitle: true,
        leading:  Navigator.canPop(context) ? Back() : null,
        title: Text(
          'Get Started',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyColor.primaryDarkColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.offAll(() => PortfolioListingPage());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  color: MyColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Millions of people use to turn their ideas into reality.",
                style: TextStyle(
                  color: MyColor.darkGreyColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              rectAngleDesignTextField(
                context: context,
                controller:getXController.GetStartedAngleTextController ,
                hintText: 'ANGLEONE',
                colorType: 4,
              ),
              const SizedBox(height: 20),
              LabeledTextField(label:"Client ID"),
              TextFromField(
                controller:getXController.clientIdCtr,
                hintText: "Client ID",
                hintTextColor:MyColor.HintColor,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 10),
              LabeledTextField(label:"PIN"),
              TextFromField(
                controller:getXController.pinCtr,
                keyboardType: TextInputType.number,
                hintText: "****",
                hintTextColor:MyColor.HintColor,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 10),
              LabeledTextField(label:"TOTP"),
              TextFromField(
                controller:getXController.totpCtr,
                hintText: "TOTP",
                hintTextColor:MyColor.HintColor,
                // prefix: appEmailLogo,
                obscureText: false,
                borderColor: MyColor.TextFormBorderGreyColor,
              ),
              const SizedBox(height: 30),
              myButton(
                context: context,
                onTap: getXController.getStartedBrokerConnectNow,
                btnName: 'Connect Now',
              ),
              const SizedBox(height: 18),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Obx(
              //       () => Checkbox(
              //         value: getXController.isChecked.value,
              //         onChanged: (value) {
              //           getXController.toggleCheckbox();
              //         },
              //       ),
              //     ),
              //     // const Text("Don't ask again",style:TextStyle( color: MyColor.darkGreyColor,)),
              //     // const SizedBox(width: 5),
              //     // GestureDetector(
              //     //   onTap: () {
              //     //     Get.offAll(() => PortfolioListingPage());
              //     //   },
              //     //   child: const Text(
              //     //     'Skip?',
              //     //     style: TextStyle(
              //     //       color: MyColor.primaryColor,
              //     //     fontWeight: FontWeight.bold,
              //     //       decoration: TextDecoration.underline,
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
