
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/my_colors.dart';

class CircularProgressDialog {
  bool _dialogIsOpen = false;

  showProgressDialog({
    bool barrierDismissible = false,
    required BuildContext context,
  }) {
    _dialogIsOpen = true;
    return showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          return ProgressDialogWidget();
        });
  }

  void close(BuildContext context) {
    if (_dialogIsOpen) {
      Navigator.pop(context);
      _dialogIsOpen = false;
    }
  }
}

class ProgressDialogWidget extends StatefulWidget {
  @override
  _ProgressDialogWidgetState createState() => _ProgressDialogWidgetState();
}

class _ProgressDialogWidgetState extends State<ProgressDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                ///backgroundColor: Color.fromARGB(255, 172, 172, 172),
                strokeWidth: 5.0,
                color: MyColor.primaryColor,
              )),
        ),
      ),
    );
  }

  dialogContent(BuildContext context) {
    return SizedBox(
      child: Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 40.0,
          width: 40.0,
          padding: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
            color: Color.fromARGB(255, 93, 128, 11),
            strokeWidth: 4.0,
            value: 30,
            //valueColor: AlwaysStoppedAnimation(Colors.green),
            //valueColor: Colors.amber,
          ),
        ),
      ),
    );
  }
}
