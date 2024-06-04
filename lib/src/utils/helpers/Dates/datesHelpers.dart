class DateHelpers{
  static String getStarDate(){
    var _date = DateTime.now();
    return "${_date.toLocal().day}/${_date.toLocal().month}/${_date.toLocal()}";
  }
}