import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();
const String regexPattern =
    r'^(http|https):\/\/[\w\-]+(\.[\w\-]+)+[\w\-.,@?^=%&:/~\+#]*[\w\-@?^=%&/~\+#]\.mp4$';
final RegExp regExp = RegExp(regexPattern);
void dismissKeyboard([BuildContext? context]) {
  if (context == null) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    return;
  }

  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!(currentFocus.hasPrimaryFocus)) {
    currentFocus.unfocus();
  }
}
