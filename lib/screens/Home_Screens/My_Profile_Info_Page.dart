
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../controllers/homescreen_controller.dart';
import '../../controllers/login_controller.dart';
import '../../resources/my_assets.dart';
import '../../resources/my_colors.dart';
import '../../utils/my_global.dart';
import '../../utils/widgets/TextFeild.dart';
import '../../utils/widgets/TextFormFeild.dart';
import '../../utils/widgets/my_button.dart';

class MyProfileInfo extends StatefulWidget {
  const MyProfileInfo({Key? key}) : super(key: key);

  @override
  State<MyProfileInfo> createState() => _MyProfileInfoState();
}

class _MyProfileInfoState extends State<MyProfileInfo> {
  final LoginController getxcontroller = Get.put(LoginController());
  final HomeScreenController controller = Get.find<HomeScreenController>();

  XFile? profilePic;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() async {
    await getxcontroller.loadProfileData();
    await controller.getPortfolioProfileViewData();
    getxcontroller.aboutMyPortfolio.text = controller.description.toString();
    print("decription---${controller.description.toString()}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColor.primaryDarkColor,
          ),
        ),
        centerTitle: true,
        leading: Back(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            await refresh();
            setState(() {});
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          child: profilePic != null
                              ? ClipOval(
                                  child: Container(
                                      color: Colors.grey.shade200,
                                      child: Image.file(
                                        File(profilePic!.path),
                                        height: Get.height * 0.15,
                                        width: Get.height * 0.15,
                                        fit: BoxFit.cover,
                                      )),
                                ) : controller.profileImg.isEmpty
                              ? ClipOval(
                                  child: Container(
                                      color: Colors.grey.shade200,
                                      child: Image(
                                        image: portfolioprofileLogo,
                                        height: Get.height * 0.15,
                                        width: Get.height * 0.15,
                                        fit: BoxFit.cover,
                                      )),
                                )
                              : ClipOval(
                                  child: Container(color: Colors.grey.shade200, child: Image.network(controller.profileImg, height: Get.height * 0.15, width: Get.height * 0.15, fit: BoxFit.cover)),
                                ),
                        ),
                        Positioned(
                            right: 0,
                            top: 7,
                            child: InkWell(
                              onTap: () {
                                if(profilePic != null){
                                  profilePic = null;
                                  setState(() {});
                                  return;
                                }
                                showModalBottomSheet(
                                    enableDrag: false,
                                    showDragHandle: false,
                                    context: context, builder: (context){
                                  return Container(
                                    height: Get.height * 0.1,
                                    margin: EdgeInsets.only(top: 20,bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Get.back();
                                           profilePic = await ImagePicker().pickImage(source: ImageSource.camera);
                                           if(profilePic != null) {
                                             Directory directory = await getApplicationCacheDirectory();
                                            profilePic = await FlutterImageCompress.compressAndGetFile(
                                               profilePic!.path,
                                               '${directory.path}/images_data_${DateTime
                                                   .now()
                                                   .microsecondsSinceEpoch}.png',
                                               format: CompressFormat.png,
                                               quality: 20,
                                               minWidth: 300,
                                             );
                                            setState(() {});
                                           }
                                          },
                                          borderRadius: BorderRadius.circular(5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(CupertinoIcons.camera_fill,size: 40,color: MyColor.white,),
                                              Text("Camera",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Get.back();
                                            profilePic = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            if(profilePic != null) {
                                              Directory directory = await getApplicationCacheDirectory();
                                              profilePic = await FlutterImageCompress.compressAndGetFile(
                                                profilePic!.path,
                                                '${directory.path}/images_data_${DateTime
                                                    .now()
                                                    .microsecondsSinceEpoch}.png',
                                                format: CompressFormat.png,
                                                quality: 20,
                                                minWidth: 300,
                                              );
                                              setState(() {});
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(CupertinoIcons.photo_fill_on_rectangle_fill,size: 40,color: MyColor.white,),
                                              Text("Gallery",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                  decoration: BoxDecoration(color:profilePic == null ? MyColor.primaryColor.withOpacity(0.8) : Colors.red.shade300, shape: BoxShape.circle),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                   profilePic == null ? Icons.edit : CupertinoIcons.xmark,
                                    size: 15,
                                    color: Colors.white,
                                  )),
                            ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LabeledTextField(label: "Username"),
                TextFromField(
                  controller: getxcontroller.MyprofileUserNameController,
                  prefix: Icons.perm_identity,
                  hintText: "Username",
                  hintTextColor: MyColor.HintColor,
                  obscureText: false,
                  borderColor: MyColor.TextFormBorderGreyColor,
                  readOnly: true,
                ),
                const SizedBox(height: 14),
                LabeledTextField(label: "Email address"),
                TextFromField(
                  controller: getxcontroller.MyprofileEmailController,
                  prefix: Icons.email_outlined,
                  hintText: "info@example.com",
                  hintTextColor: MyColor.HintColor,
                  obscureText: false,
                  borderColor: MyColor.TextFormBorderGreyColor,
                  readOnly: true,
                ),
                const SizedBox(height: 14),
                LabeledTextField(label: "Phone number"),
                TextFromField(
                  controller: getxcontroller.MyprofilePhoneNoController,
                  prefix: Icons.phone_in_talk_outlined,
                  hintText: "7348756812",
                  hintTextColor: MyColor.HintColor,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  borderColor: MyColor.TextFormBorderGreyColor,
                  readOnly: true,
                ),
                const SizedBox(height: 14),
                LabeledTextField(label: "About my portfolio"),
                const SizedBox(height: 2),
                TextFormField(
                  controller: getxcontroller.aboutMyPortfolio,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  maxLines: null,
                  minLines: 1,
                  inputFormatters: null,
                  style: TextStyle(color: MyColor.black),
                  decoration: InputDecoration(
                    hintText: "write your portfolio",
                    hintStyle: TextStyle(color: MyColor.HintColor),
                    prefixIcon: Icon(Icons.bar_chart_sharp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: MyColor.TextFormBorderGreyColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  ),
                ),
                SizedBox(height: 24),
                myButton(
                  context: context,
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    // if (getxcontroller.aboutMyPortfolio.text.isEmpty) {
                    //   DisplaySnackbar().errorSnackBar(title: "Failed", msg: "Enter your portfolio information.");
                    // } else {
                    await getxcontroller.UpdateprofileAboutMyPortfolio(profilePic);
                    // }
                  },
                  btnName: 'Save',
                ),
                const SizedBox(height: 4),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDeleteAccountDialog(context);
                      },
                      child: Text(
                        "Delete My Account",
                        style: TextStyle(
                          color: MyColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -12),
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.6, right: MediaQuery.of(context).size.height * 0.025),
                        child: Divider(
                          thickness: 1,
                          color: MyColor.primaryColor,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: BorderSide(color: MyColor.white)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColor.white,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Are you sure?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: MyColor.black),
                ),
                SizedBox(height: 10),
                Text(
                  "If you delete your account,\nyour data will be lost, Are you sure you want to continue?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColor.matricsgreyColor,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: MyColor.whiteGreyColor)),
                    ),
                    onPressed: () async {
                      await getxcontroller.deleteUserAccount();
                    },
                    child: Text(
                      "Delete account",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
