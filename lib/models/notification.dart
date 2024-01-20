import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 1)
class NotificationCKC {
  @HiveField(0)
  late int iconNumb;
  @HiveField(1)
  late DateTime notiDate;
  @HiveField(2)
  late String title;
  @HiveField(3)
  late String content;

  NotificationCKC({
    required this.iconNumb,
    required this.notiDate,
    required this.title,
    required this.content,
  });
}
