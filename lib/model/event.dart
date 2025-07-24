import 'package:latlong2/latlong.dart';

class Event {
  static const String collectionName='Events';
  String id;
  String image;
  String darkImage;
  String title;
  String eventName;
  String description;
  String time;
  DateTime dateTime;
  bool isFavorite;

  Event(
      {this.id = '', this.isFavorite = false, required this.darkImage,
        required this.title, required this.eventName,
        required this.dateTime, required this.image,
        required this.description, required this.time });

  ///json => obj
  Event.fromFireStore(Map<String,dynamic> data):this(
    id:data['id'] ,
    image:data['image']  ,
    darkImage: data['darkImage'],
    title:data['title'] ,
    eventName: data['eventName'] ,
    description:data['description'] ,
    time:data['time'] ,
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    isFavorite: data['isFavorite'],

  );


  ///object => json
  Map<String, dynamic> toFireStore() {
    return {
      'id':id,
      'image':image,
      'darkImage':darkImage,
      'title':title,
      'eventName':eventName,
      'description':description,
      'time':time,
      'dateTime':dateTime.millisecondsSinceEpoch,
      'isFavorite':isFavorite,
    };
  }
  Event copyWith({
    String? id,
    String? image,
    String? darkImage,
    String? title,
    String? eventName,
    String? description,
    String? time,
    DateTime? dateTime,
    String? locationName,
    bool? isFavorite,
  }) {
    return Event(
      id: id ?? this.id,
      image: image ?? this.image,
      darkImage: darkImage ?? this.darkImage,
      title: title ?? this.title,
      eventName: eventName ?? this.eventName,
      description: description ?? this.description,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}