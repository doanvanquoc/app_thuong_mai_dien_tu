class Noti {
  final int notiID;
  final String title;
  final String content;
  final String notiDate;
  final int userID;

  Noti(this.notiID, this.title, this.content, this.notiDate, this.userID);

  Noti.fromJson(Map<String, dynamic> json)
      : notiID = json['notificationID'],
        title = json['title'],
        content = json['content'],
        notiDate = json['notification_date'],
        userID = json['userID'];
}
