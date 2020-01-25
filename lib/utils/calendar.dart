class Calendar {
  int __day;
  String __dayOfWeek;

  Calendar(int day, String dayOfWeek) {
    this.__day = day;
    this.__dayOfWeek = dayOfWeek;
  }

  String get getDayOfWeek => __dayOfWeek;

  int get getDay => __day;


}