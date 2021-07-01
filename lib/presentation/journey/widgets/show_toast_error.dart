
import 'package:fluttertoast/fluttertoast.dart';

void showError(){
  Fluttertoast.showToast(
    msg: "Error",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
