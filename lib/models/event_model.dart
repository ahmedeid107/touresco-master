
class EventModel {
  String title   ;
  String body    ;
  DateTime date  ;
  String type    ;
  String? tripId ;
  String? path   ;

  EventModel({
    required this.date,
    required this.type,
    required this. body,
    required this.title,
    required this.tripId,
    required this.path,
  });

  static EventModel fromJson(Map<String , dynamic > map){
  return  EventModel(
     title:map["title"],
     date:DateTime.parse(map['program_date']),
     type:map["type"],
     tripId:map["trip_id"],
     body:map["body"],
     path:map["path"],
  );
  }
}
