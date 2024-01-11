import 'package:app_thuong_mai_dien_tu/views/product_detail/product_detail_view.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_filter.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_history.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_not_fond_view.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextController = TextEditingController();
  String reslutSearchTextController = "";
  String contenHistory = "";
  bool onSearch = false;
  bool checkNotDataPage = false;
  bool checkDataPage = false;
  bool checkResultSearch = false;
  bool checkHistory = true;
  final FocusNode focusNode = FocusNode();

  int count = 0;
  // List<String> query = [];
  List historyLstMain = [
    'Iphone 15',
    'Iphone 13',
    'Iphone 11',
    'Samsung galaxy S23 Ultra'
  ];
  List historyLst = [
    'Iphone 15',
    'Iphone 13',
    'Iphone 11',
    'Samsung galaxy S23 Ultra'
  ];

  // List historyLstNew = [];
  // void loadHistoryNew() {
  //   historyLstNew.add(historyLst.reversed.toString());
  // }
  List historyLstReversed = [];

  bool checkData(value) {
    for (var item in historyLstMain) {
      if (item.toString().contains(value.toString())) {
        return true;
      }
    }
    return false;
  }

  void checkDataSame(value) {
    for (var item in historyLstMain) {
      if (item.toString() == value) {
        historyLst.remove(value);
        historyLstReversed.clear();
        historyLst.add(value);
        historyLstReversed.addAll(historyLst.reversed);

        return;
      }
    }
    historyLstReversed.clear();
    historyLst.add(value);
    historyLstReversed.addAll(historyLst.reversed);
  }

  int incrCount(value) {
    for (var item in historyLst) {
      if (item.toString().contains(value.toString())) {
        count++;
      }
    }
    return count;
  }

  void onTapHistory(value) {
    setState(() {
      searchTextController.text = value;
    });
  }

  void checkSearch(
      checkNotDataPage, checkHistory, checkDataPage, checkResultSearch) {
    this.checkNotDataPage = checkNotDataPage;
    this.checkHistory = checkHistory;
    this.checkDataPage = checkDataPage;
    this.checkResultSearch = checkResultSearch;
  }

  @override
  void initState() {
    super.initState();
    historyLstReversed.addAll(historyLst.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 60),
              TextField(
                focusNode: focusNode,
                onTap: () {
                  setState(() {
                    checkSearch(false, true, false, false);
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    print(value);
                    reslutSearchTextController = value;
                    if (checkData(value)) {
                      checkSearch(false, false, true, true);
                    } else {
                      checkSearch(true, false, false, true);
                    }
                    checkDataSame(value);
                  });
                },
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        reslutSearchTextController = searchTextController.text;
                        if (checkData(searchTextController.text)) {
                          checkSearch(false, false, true, true);
                        } else {
                          checkSearch(true, false, false, true);
                        }
                        historyLst.add(reslutSearchTextController);
                        focusNode.unfocus();
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.vertical(
                                  top: Radius.circular(40))),
                          context: context,
                          builder: (_) {
                            return const SearchFilter();
                          });
                    },
                    icon: const Icon(
                      Icons.filter_frames_rounded,
                      color: Color(0xFF01B763),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Visibility(
                visible: checkResultSearch,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: "Kết quả tìm kiếm",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: ' "$reslutSearchTextController"',
                                style: const TextStyle(
                                    color: Color(0xFF01B763),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                    Text(
                      "${incrCount(reslutSearchTextController)} kết quả",
                      style: const TextStyle(
                        color: Color(0xFF01B763),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Visibility(
                  visible: checkHistory,
                  child: Expanded(
                    child: SearchHistory(
                      historyLst: historyLstReversed,
                      onTapHistory: onTapHistory,
                    ),
                  )),
              Visibility(
                  visible: checkNotDataPage,
                  child: SearchNotFound(
                    reslutSearchTextController: reslutSearchTextController,
                  )),
              Visibility(
                visible: checkDataPage,
                child: Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 2.2,
                      ),
                      itemCount: 10,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ProductDetail()));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 200,
                                    child: Image.asset(
                                      'assets/images/phone2.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Iphone 15 Pro Max 8G/ 128GB - VN',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_border,
                                        color: Color(0xFF01B763),
                                      ),
                                      const Text('4.5'),
                                      const SizedBox(width: 10),
                                      const Text('|'),
                                      const SizedBox(width: 10),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFF01B763)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          '3000 đã bán',
                                          style: TextStyle(
                                              color: Color(0xFF01B763)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Text(
                                  '32.900.000đ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF01B763),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
