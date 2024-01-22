import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 1)
class NotificationCKC {
  @HiveField(0)
  final int notificationID;
  @HiveField(1)
  final int userID;
  @HiveField(2)
  final String notiDate;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String content;

  NotificationCKC({
    required this.notificationID,
    required this.userID,
    required this.notiDate,
    required this.title,
    required this.content,
  });

  NotificationCKC.fromJson(
    Map<String, dynamic> json,
  )   : notificationID = json['notificationID'],
        userID = json['userID'],
        notiDate = json['notification_date'],
        title = json['title'],
        content = json['content'];
}
