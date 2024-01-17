import 'package:app_thuong_mai_dien_tu/data_sources/repo/company_api.dart';
import 'package:app_thuong_mai_dien_tu/data_sources/repo/product_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/history_search.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/presenters/company_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/product_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_filter.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_history.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_not_fond_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextController = TextEditingController();
  String reslutSearchTextController = "";
  bool onSearch = false;
  bool checkNotDataPage = false;
  bool checkDataPage = false;
  bool checkResultSearch = false;
  bool checkHistory = true;
  final FocusNode focusNode = FocusNode();

  int count = 0;

//lấy data
  final productPresenter = ProductPresenter.instance;
  final companyPresenter = CompanyPresenter.instance;
  List<Product> products = [];
  List<Company> companies = [];
  @override
  void initState() {
    productPresenter.getAllProduct().then((value) {
      setState(() {
        products = value;
      });
    });

    companyPresenter.getAllCompany().then((value) {
      setState(() {
        companies = value;
      });
    });

    loadHistoryLocal();
    historyLstReversed.addAll(historyLst.reversed);
    super.initState();
  }

  List historyLst = [];
  List historyLstReversed = [];

//LƯU LOCAL
  var historiesBox = Hive.box<History>('history');

  void addHistoryLocal(String value) {
    int index = 0;
    final his = History(searchHistory: value);

    setState(() {
      if (value.isEmpty) {
        return;
      }

      for (var item in historyLst) {
        if (item.toString() == value) {
          historiesBox.deleteAt(index);
          historiesBox.add(his);

          historyLst.remove(value);

          historyLstReversed.clear();

          historyLst.add(value);

          historyLstReversed.addAll(historyLst.reversed);

          return;
        }
      }
      historyLstReversed.clear(); //làm trống
      historiesBox.add(his); //thêm vào local
      historyLst.add(value); //thêm mới ls vào list phụ
      historyLstReversed.addAll(historyLst.reversed); //đảo ngược
      index += 1;
    });
  }

  void loadHistoryLocal() {
    for (var element in historiesBox.values.toList()) {
      historyLst.add(element.searchHistory);
    }
  }
//

  void onTapHistory(value) {
    searchTextController.text = value;
  }

  void deletedAll() {
    setState(() {
      historiesBox.clear();
      historyLstReversed = [];
      historyLst = [];
      loadHistoryLocal();
    });
  }

  void deletedItem(int index) {
    setState(() {
      historiesBox.deleteAt(index);
      historyLstReversed = [];
      historyLst = [];
      loadHistoryLocal();
      historyLstReversed.addAll(historyLst.reversed);
    });
  }

//ẩn hiện page
  void checkSearch(
      {required checkNotDataPage,
      required checkHistory,
      required checkDataPage,
      required checkResultSearch}) {
    this.checkNotDataPage = checkNotDataPage;
    this.checkHistory = checkHistory;
    this.checkDataPage = checkDataPage;
    this.checkResultSearch = checkResultSearch;
  }

  List<dynamic> productSearch(
      String value, List<dynamic> lstData, List<dynamic> lstSearch) {
    lstSearch.clear();
    for (var element in lstData) {
      if (element.productName.toUpperCase().contains(value.toUpperCase())) {
        lstSearch.add(element);
      }
    }
    return lstSearch;
  }

  //Danh sach theo từ khóa tìm kiếm
  List<Product> productsSearch = [];

  //Kiểm tra có trùng data ko
  bool checkData(value) {
    for (var item in products) {
      if (item.productName
          .toString()
          .toUpperCase()
          .contains(value.toString().toUpperCase())) {
        productSearch(value, products, productsSearch);
        return true;
      }
    }
    return false;
  }

  String checkCategory = "";

  int id = -1;
  Future<void> checkOption(value) async {
    print(value);
    CompanyAPI.instance.getCompanyId(value).then((valueId) {
      setState(() {
        id = valueId;
      });
    });
  }

  int priceFrom = 0;
  int priceTo = 0;

  void priceFromTo(from, to) {
    //lay khoang gia
    setState(() {
      priceFrom = from;
      priceTo = to;
    });
  }

  void applyOption() {
    //them vao gio hang
    setState(() {
      searchsCompanies(id, products, productsSearch);
      checkSearch(
          checkNotDataPage: false,
          checkHistory: false,
          checkDataPage: true,
          checkResultSearch: true);
      Navigator.pop(context);
    });
  }

  List<dynamic> searchsCompanies(
      int value, List<Product> lstData, List<dynamic> lstSearch) {
    lstSearch.clear();
    for (var element in lstData) {
      if (element.company.companyID == value &&
          (element.price >= 10000000 && element.price <= 20000000)) {
        lstSearch.add(element);
      }
    }
    return lstSearch;
  } //demo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              TextField(
                focusNode: focusNode,
                onTap: () {
                  setState(() {
                    productsSearch = [];
                    checkSearch(
                        checkNotDataPage: false,
                        checkHistory: true,
                        checkDataPage: false,
                        checkResultSearch: false);
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      checkSearch(
                          checkNotDataPage: true,
                          checkHistory: false,
                          checkDataPage: false,
                          checkResultSearch: true);
                      return;
                    }

                    reslutSearchTextController = value;
                    if (checkData(value)) {
                      checkSearch(
                          checkNotDataPage: false,
                          checkHistory: false,
                          checkDataPage: true,
                          checkResultSearch: true);
                    } else {
                      checkSearch(
                          checkNotDataPage: true,
                          checkHistory: false,
                          checkDataPage: false,
                          checkResultSearch: true);
                    }
                    addHistoryLocal(value);
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
                          checkSearch(
                              checkNotDataPage: false,
                              checkHistory: false,
                              checkDataPage: true,
                              checkResultSearch: true);
                        } else {
                          checkSearch(
                              checkNotDataPage: true,
                              checkHistory: false,
                              checkDataPage: false,
                              checkResultSearch: true);
                        }
                        addHistoryLocal(reslutSearchTextController);
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
                            return SearchFilter(
                              checkOptioin: checkOption,
                              applyOption: applyOption,
                              priceFT: priceFromTo,
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.filter_frames_rounded,
                      color: AppColor.primaryColor,
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
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                    Text(
                      "${productsSearch.length} kết quả",
                      style: const TextStyle(
                        color: AppColor.primaryColor,
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
                      deletedAll: deletedAll,
                      deletedItem: deletedItem,
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
                      itemCount: productsSearch.length,
                      itemBuilder: (_, index) {
                        return ProductItem(product: productsSearch[index]);
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
