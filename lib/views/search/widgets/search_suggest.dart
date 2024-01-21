import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchSuggest extends StatefulWidget {
  SearchSuggest({
    super.key,
    required this.historySuggest,
    required this.onTapHistory,
  });
  List<Product> historySuggest;
  Function onTapHistory;

  @override
  State<SearchSuggest> createState() => _SearchSuggestState();
}

class _SearchSuggestState extends State<SearchSuggest> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gợi ý",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Divider(),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 24),
              shrinkWrap: true,
              itemCount: widget.historySuggest.length,
              itemBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 33),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Text(
                          widget.historySuggest[index].productName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          widget.onTapHistory(
                              widget.historySuggest[index].productName);
                          // setState(() {
                          //   searchTextController.text = widget.historyLst[index];
                          // });
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
