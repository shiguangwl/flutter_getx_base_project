import 'package:logger/logger.dart';
import 'dart:developer';

const String _tag = "!@!@!@--->>>";

Logger _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
  ),
);

logV(dynamic msg, {String tag = _tag}) {
  _logger.v("$msg");
}

logD(dynamic msg, {String tag = _tag}) {
  _logger.d("$msg");
}

logI(dynamic msg, {String tag = _tag}) {
  _logger.i("$msg");
}

logW(dynamic msg, {String tag = _tag}) {
  _logger.w("$msg");
}

logE(dynamic msg, {String tag = _tag}) {
  _logger.e("$msg");
}

logWTF(dynamic msg, {String tag = _tag}) {
  log(msg);
}
