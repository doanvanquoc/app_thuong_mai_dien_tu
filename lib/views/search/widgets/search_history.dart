import 'package:app_thuong_mai_dien_tu/models/history_search.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class SearchHistory extends StatefulWidget {
  SearchHistory({
    super.key,
    required this.historyLst,
    required this.onTapHistory,
    required this.deletedAll,
    required this.deletedItem,
  });
  List historyLst;
  Function onTapHistory;
  Function deletedAll;

  Function deletedItem;

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Lịch sử",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                widget.deletedAll();
              },
              child: const Text(
                "Xóa tất cả",
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 24),
              shrinkWrap: true,
              itemCount: widget.historyLst.length,
              itemBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Text(
                          widget.historyLst[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          widget.onTapHistory(widget.historyLst[index]);
                          // setState(() {
                          //   searchTextController.text = widget.historyLst[index];
                          // });
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            List<dynamic> lst = [];
                            int i = 0;
                            lst.addAll(widget.historyLst.reversed);
                            for (var element in lst) {
                              if (element == widget.historyLst[index]) {
                                widget.deletedItem(i);
                              }
                              i++;
                            }
                          },
                          icon: const Icon(Icons.remove_outlined))
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
