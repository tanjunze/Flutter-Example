import 'package:fluttertoast/fluttertoast.dart';

void showShortToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1);
}
