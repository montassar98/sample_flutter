import 'package:intl/intl.dart';

class DateFormatter{

  static String parseTimeStamp(int value) {
    var date = DateTime.fromMillisecondsSinceEpoch(value);
    var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(date);
    return d12;
  }
}