

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../resources/my_colors.dart';

class OKDialog extends StatefulWidget {
  String? title;
  String? descriptions;
  AssetImage img;

  OKDialog({Key? key, required this.title, required this.descriptions, required this.img}) : super(key: key);

  @override
  _OKDialogState createState() => _OKDialogState();
}

class _OKDialogState extends State<OKDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 20.0,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SizedBox(
        child: Container(
      // padding:
      //     const EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    gradient: LinearGradient(colors: [
                      MyColor.primaryDarkColor.withOpacity(0.8),
                      MyColor.primaryDarkColor.withOpacity(0.8),
                    ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.exclamation,
                        color: Colors.red.shade800,
                        size: 30,
                      ))),
              const SizedBox(height: 10),
              widget.title != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: MyColor.primaryColor,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox(height: 10),
              const SizedBox(height: 10),
              widget.descriptions != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(widget.descriptions!, textAlign: TextAlign.center, style: const TextStyle(color: Color.fromARGB(255, 90, 90, 90), fontSize: 14.0)),
                        )
                      ],
                    )
                  : SizedBox(),
              const SizedBox(height: 15),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 100.0,
                  height: 35.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3.0),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    // color: Colors.red,
                    gradient: LinearGradient(
                        colors: [
                          MyColor.primaryDarkColor.withOpacity(0.7), 
                          MyColor.primaryDarkColor, 
                        ]),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(15),
                    //   topRight: Radius.circular(15),
                    // ),
                  ),
                  child: Container(
                    width: 97.0,
                    height: 32.0,
                    padding: const EdgeInsets.all(3.0),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      // color: Colors.red,
                      gradient: LinearGradient(
                          begin: Alignment.centerRight, 
                          end: Alignment.centerLeft, 
                          colors: [
                            MyColor.primaryDarkColor.withOpacity(0.7),
                            MyColor.primaryDarkColor,
                          ]),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(15),
                      //   topRight: Radius.circular(15),
                      // ),
                    ),
                    child: Text(
                      "OK",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,

                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    ));
  }
}

class OKLogOutDialog extends StatefulWidget {
  String? title;
  String? descriptions;
  AssetImage img;
  Function()? okButton;

  OKLogOutDialog({Key? key, required this.title, required this.descriptions, required this.img, required this.okButton}) : super(key: key);

  @override
  _OKLogOutDialogState createState() => _OKLogOutDialogState();
}

class _OKLogOutDialogState extends State<OKLogOutDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 20.0,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SizedBox(
        child: Container(
      // padding:
      //     const EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    gradient: LinearGradient(colors: [
                      MyColor.primaryDarkColor.withOpacity(0.8),
                      MyColor.primaryDarkColor.withOpacity(0.8),
                    ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.exclamation,
                        color: Colors.red.shade800,
                        size: 30,
                      ))),
              const SizedBox(height: 10),
              widget.title != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: MyColor.primaryColor,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox(height: 10),
              const SizedBox(height: 10),
              widget.descriptions != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(widget.descriptions!, textAlign: TextAlign.center, style: const TextStyle(color: Color.fromARGB(255, 90, 90, 90), fontSize: 14.0)),
                        )
                      ],
                    )
                  : SizedBox(),
              const SizedBox(height: 15),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: 100.0,
                  height: 35.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3.0),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    // color: Colors.red,
                    gradient: LinearGradient(
                        colors: [
                          MyColor.primaryDarkColor.withOpacity(0.7), 
                          MyColor.primaryDarkColor, 
                        ]),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(15),
                    //   topRight: Radius.circular(15),
                    // ),
                  ),
                  child: Container(
                    width: 97.0,
                    height: 32.0,
                    padding: const EdgeInsets.all(3.0),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      // color: Colors.red,
                      gradient: LinearGradient(
                          begin: Alignment.centerRight, 
                          end: Alignment.centerLeft, 
                          colors: [
                            MyColor.primaryDarkColor.withOpacity(0.7),
                            MyColor.primaryDarkColor,
                          ]),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(15),
                      //   topRight: Radius.circular(15),
                      // ),
                    ),
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,

                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: widget.okButton,
                child: Container(
                  width: 100.0,
                  height: 35.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3.0),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    // color: Colors.red,
                    gradient: LinearGradient(
                        colors: [
                          MyColor.primaryDarkColor.withOpacity(0.7), 
                          MyColor.primaryDarkColor, 
                        ]),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(15),
                    //   topRight: Radius.circular(15),
                    // ),
                  ),
                  child: Container(
                    width: 97.0,
                    height: 32.0,
                    padding: const EdgeInsets.all(3.0),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      // color: Colors.red,
                      gradient: LinearGradient(
                          begin: Alignment.centerRight, 
                          end: Alignment.centerLeft, 
                          colors: [
                            MyColor.primaryDarkColor.withOpacity(0.7),
                            MyColor.primaryDarkColor,
                          ]),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(15),
                      //   topRight: Radius.circular(15),
                      // ),
                    ),
                    child: Text(
                      "Ok",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,

                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    ));
  }
}
