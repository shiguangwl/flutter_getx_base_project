import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoadingWidget extends StatelessWidget {
  final bool? hidden;

  const LoadingWidget({Key? key, this.hidden}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hidden == true) {
      return Container();
    } else {
      return const Center(
        //保证控件居中效果
        child: CupertinoActivityIndicator(
          radius: 14,
          color: Colors.black38,
        ),
      );
    }
  }
}

class Loading {
  static showToast(
    String msg, {
    double fontSize = 26,
    Toast toast = Toast.LENGTH_SHORT,
    Color bgColor = Colors.black,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.CENTER,
    Function()? dismiss,
  }) {
    // Loading.dissmiss();
    Fluttertoast.showToast(
      msg: msg,
      gravity: gravity,
      toastLength: toast,
      fontSize: fontSize,
      textColor: textColor,
      backgroundColor: bgColor,
    ).then((value) {
      if (dismiss != null) {
        dismiss();
      }
    });
  }

  // /// 提示文字
  // static void show({
  //   String? title,
  //   double textFont = 14.0,
  // }) {
  //   EasyLoading.instance
  //     ..displayDuration = const Duration(milliseconds: 2000)
  //     ..indicatorType = EasyLoadingIndicatorType.circle
  //     ..loadingStyle = EasyLoadingStyle.custom
  //     ..maskType = EasyLoadingMaskType.custom
  //     ..indicatorSize = 45.0
  //     ..radius = 6.0
  //     ..backgroundColor = Colors.black12
  //     ..indicatorColor = Colors.yellow
  //     ..textColor = Colors.yellow
  //     ..maskColor = Colors.transparent;
  //   EasyLoading.show(
  //     status: title,
  //     indicator: const CupertinoActivityIndicator(
  //       radius: 14,
  //       color: Colors.white,
  //     ),
  //   );
  // }
  //
  // static void dissmiss() {
  //   EasyLoading.dismiss();
  // }
}
