import 'package:app_thuong_mai_dien_tu/models/notification.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/presenters/notification_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/views/notification/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, required this.user});
  final User user;
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationPresenter = NotificationPresenter.instance;
  List<NotificationCKC> notifications = [];
  @override
  void initState() {
    NotificationPresenter.instance
        .getNotificationByUserID(widget.user.userID)
        .then((value) {
      setState(() {
        notifications = value;
        NotificationPresenter.addNotificationLocal(notifications);
        NotificationPresenter.getNotification(widget.user.userID);
      });
    });
    super.initState();
  }
  // List lstNotifications = [
  //   '2024-01-08 21:52:23.546415',
  //   'Thiết lập tài khoản thành công!',
  //   'Tài khoản của bạn đã được tạo!'
  // ];

  // int countDate(DateTime value) {
  //   DateTime now = DateTime.now();
  //   if (now.day == value.day && now.month == value.month) {
  //     return 0;
  //   } else {
  //     return now.day - value.day;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Thông báo",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: notifications.length,
          itemBuilder: (_, index) {
            if (NotificationPresenter.notificationsReversed.isEmpty) {
              return null;
            }
            if (index == 0 ||
                ReviewPresenter.converDate(NotificationPresenter
                        .notificationsReversed[index].notiDate
                        .toString()) !=
                    ReviewPresenter.converDate(NotificationPresenter
                        .notificationsReversed[index - 1].notiDate
                        .toString())) {
              // Nếu là ngày đầu tiên hoặc ngày khác ngày trước đó, hiển thị tiêu đề
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ReviewPresenter.converDate(NotificationPresenter
                          .notificationsReversed[index].notiDate
                          .toString()),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  NotificationItem(
                      notification:
                          NotificationPresenter.notificationsReversed[index])
                ],
              );
              // return const NotificationItem();
            }
            return NotificationItem(
                notification:
                    NotificationPresenter.notificationsReversed[index]);
          },
        ),
      ),
    );
  }
}
