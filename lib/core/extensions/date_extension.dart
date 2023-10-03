extension DateExtension on int {
  String toDate({String format = 'dd-MM-yyyy'}) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(this);
    return "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }
}
