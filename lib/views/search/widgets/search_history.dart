import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchHistory extends StatefulWidget {
  SearchHistory({
    super.key,
    required this.historyLst,
    required this.onTapHistory,
  });
  List historyLst;
  Function onTapHistory;

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
                setState(() {
                  widget.historyLst.clear();
                });
              },
              child: const Text(
                "Xóa tất cả",
                style: TextStyle(
                  color: Color(0xFF01B763),
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
                            setState(() {
                              widget.historyLst.removeAt(index);
                            });
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
