import 'package:app_thuong_mai_dien_tu/data_sources/repo/company_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/history_search.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:app_thuong_mai_dien_tu/presenters/company_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/history_search_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/product_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_filter.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_history.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_not_fond_view.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/search_suggest.dart';
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
  bool checkNotDataPage = false;
  bool checkDataPage = false;
  bool checkResultSearch = false;
  bool checkHistory = true;
  final FocusNode focusNode = FocusNode();

//lấy data
  final productPresenter = ProductPresenter.instance;
  final companyPresenter = CompanyPresenter.instance;
  final reviewPresenter = ReviewPresenter.instanse;
  List<Product> products = [];
  List<Company> companies = [];
  List<Review> reviews = [];

  List historyLst = [];
  List historyLstReversed = [];

  bool checkSuggest = false;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });

    HistorySearchPresenter.loadHistoryLocal(
        historyLst: historyLst, historyLstReversed: historyLstReversed);
    super.initState();
  }

  void productLatest() {
    productPresenter.getLatestProduct().then((value) {
      setState(() {
        productsSearch = value;
      });
    });
  }

  void onTapHistory(value) {
    searchTextController.text = value;
  }

  void deletedAll() {
    setState(() {
      HistorySearchPresenter.historiesBox.clear();
      historyLstReversed.clear();
      historyLst.clear();
    });
  }

  void deletedItem(int index) {
    setState(() {
      HistorySearchPresenter.historiesBox.deleteAt(index);
      HistorySearchPresenter.loadHistoryLocal(
          historyLst: historyLst, historyLstReversed: historyLstReversed);
    });
  }

//ẩn hiện page
  void checkSearch(
      {required checkNotDataPage,
      required checkHistory,
      required checkDataPage,
      required checkResultSearch}) {
    this.checkNotDataPage = checkNotDataPage; //trang ko có dữ liệu
    this.checkHistory = checkHistory; //trang hiển lịch sử
    this.checkDataPage = checkDataPage; //trang dư liệu tìm kiếm
    this.checkResultSearch = checkResultSearch;
  }

  //Danh sach theo từ khóa tìm kiếm
  List<Product> productsSearch = [];

  //Kiểm tra có trùng data ko
  bool checkSameData(value) {
    for (var item in products) {
      if (item.productName
          .toString()
          .toUpperCase()
          .contains(value.toString().toUpperCase())) {
        ProductPresenter.productSearch(value, products, productsSearch);
        return true;
      }
    }
    return false;
  }

  int priceFrom = 0;
  int priceTo = 0;

  //lay khoang gia
  void priceFromTo(from, to) {
    setState(() {
      priceFrom = from;
      priceTo = to;
    });
  }

  //lấy id option
  int id = -1;
  Future<void> checkOption(value) async {
    CompanyAPI.instance.getCompanyId(value).then((valueId) {
      setState(() {
        id = valueId;
      });
    });
  }

  //Tim theo bộ lọc
  void searchsCompanies({
    required int categoryID,
    String sortName = 'Phổ biến',
    String rating = '',
    required List<Product> lstData,
    required List<Product> lstSearch,
  }) {
    setState(() {
      lstSearch.clear();
      for (var element in lstData) {
        if ((element.company.companyID == categoryID) &&
            (element.price >= int.parse("${priceFrom}000000") &&
                element.price <= int.parse("${priceTo}000000"))) {
          lstSearch.add(element);
        }
      }
    });
  }

  //dat hang
  void applyOption() {
    setState(() {
      searchsCompanies(
          categoryID: id, lstData: products, lstSearch: productsSearch);
      searchTextController.text = '';
      reslutSearchTextController = '';
      if (productsSearch.isEmpty) {
        checkSearch(
            checkNotDataPage: true,
            checkHistory: false,
            checkDataPage: false,
            checkResultSearch: true);
      } else {
        reslutSearchTextController = 'theo bộ lọc';
        checkSearch(
            checkNotDataPage: false,
            checkHistory: false,
            checkDataPage: true,
            checkResultSearch: true);
      }
      id = -1; //reset giá trị option đang chọn
    });
  }

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
                  //Khi nhấn vào textfile thì lich su hien ra
                  setState(() {
                    checkSearch(
                        checkNotDataPage: false,
                        checkHistory: true,
                        checkDataPage: false,
                        checkResultSearch: false);
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    //nhan enter nhan data
                    if (value.isEmpty) {
                      productLatest();
                      reslutSearchTextController = 'mới nhất';
                      checkSearch(
                          checkNotDataPage: false,
                          checkHistory: false,
                          checkDataPage: true,
                          checkResultSearch: true);
                      return;
                    }

                    reslutSearchTextController = value;

                    if (checkSameData(value)) {
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
                    HistorySearchPresenter.addHistoryLocal(
                        value: value,
                        historyLst: historyLst,
                        historyLstReversed: historyLstReversed);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      productsSearch = [];
                      checkSuggest = false;
                      return;
                    }
                    if (checkSameData(value)) {
                      checkSuggest = true;
                    } else {
                      productsSearch = [];
                      checkSuggest = false;
                    }
                  });
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
                        if (reslutSearchTextController.isEmpty) {
                          reslutSearchTextController = "mới nhất";
                          productLatest();
                          focusNode.unfocus();
                          checkSearch(
                              checkNotDataPage: false,
                              checkHistory: false,
                              checkDataPage: true,
                              checkResultSearch: true);
                          return;
                        }
                        if (checkSameData(searchTextController.text)) {
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
                        HistorySearchPresenter.addHistoryLocal(
                            value: reslutSearchTextController,
                            historyLst: historyLst,
                            historyLstReversed: historyLstReversed);
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
                      focusNode.unfocus();
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
                                text: productsSearch.isNotEmpty
                                    ? ' "$reslutSearchTextController"'
                                    : '',
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
                    child: checkSuggest
                        ? SearchSuggest(
                            historySuggest: productsSearch,
                            onTapHistory: onTapHistory)
                        : SearchHistory(
                            historyLst: historyLstReversed,
                            onTapHistory: onTapHistory,
                            deletedAll: deletedAll,
                            deletedItem: deletedItem,
                          ),
                  )),
              Visibility(
                visible: checkNotDataPage,
                child: const Expanded(
                  child: SearchNotFound(
                      message:
                          'Chúng tôi rất tiếc, từ khóa bạn tìm không thấy kết quả nào. Vui lòng kiểm tra lại hoặc tìm kiếm với từ khóa khác.'),
                ),
              ),
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
