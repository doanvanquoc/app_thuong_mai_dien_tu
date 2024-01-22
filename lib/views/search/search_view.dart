// ignore_for_file: unrelated_type_equality_checks

import 'package:app_thuong_mai_dien_tu/data_sources/repo/company_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
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
  final reviewPresenter = ReviewPresenter.instance;
  List<Product> productsAll = [];
  List<Company> companies = [];
  List<Review> reviews = [];

  List historyLst = [];
  List historyLstReversed = [];

  bool checkSuggest = false;

  @override
  void initState() {
    productPresenter.getAllProduct().then((value) {
      setState(() {
        productsAll = value;
      });
    });
    companyPresenter.getAllCompany().then((value) {
      setState(() {
        companies = value;
      });
    });

    productPresenter.getLatestProduct().then((value) {
      setState(() {
        productsLatest = value;
      });
    });

    productPresenter.getBestSellingProduct(10).then((value) {
      setState(() {
        productsSelling = value;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });

    HistorySearchPresenter.loadHistoryLocal(
        historyLst: historyLst, historyLstReversed: historyLstReversed);
    super.initState();
  }

  List<Product> productsLatest = [];
  List<Product> productsSelling = [];

  void getAllProduct() {}

  Future<void> productLatest() async {
    await productPresenter.getLatestProduct().then((value) {
      setState(() {
        productsSearch.clear();
        productsLatest = value;
        productsSearch.addAll(productsLatest);
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
    productsSearch.clear();

    for (var item in productsAll) {
      if (item.productName
          .toString()
          .toUpperCase()
          .contains(value.toString().toUpperCase())) {
        productsSearch.add(item);
      }
    }
    if (productsSearch.isEmpty) return false;
    return true;
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
  Future<void> checkOption(String nameCompany) async {
    await CompanyAPI.instance.getCompanyId(nameCompany).then((valueId) {
      setState(() {
        id = valueId;
      });
    });
  }

  String nameSort = '';
  void checkSort(String sort) {
    setState(() {
      nameSort = sort;
    });
  }

  String star = '-1';
  void checkRate(String rate) {
    setState(() {
      star = rate;
      print(star);
    });
  }

  bool check = false;

  List<Product> proReview = [];
  //Tim theo bộ lọc
  Future<void> searchsCompanies({
    required int categoryID,
    String rating = '',
  }) async {
    productsSearch.clear();
    if (id == -1 && star == '-1') {
      //khi nsx và dánh giá ko chọn
      if (nameSort == 'Mới nhất') {
        // productsSearch.addAll(productsLatest);
        for (var element in productsLatest) {
          if ((element.price >= int.parse("${priceFrom}000000") &&
              element.price <= int.parse("${priceTo}000000"))) {
            productsSearch.add(element);
          }
        }
        nameSort = '';
        return;
      }
      if (nameSort == 'Phổ biến') {
        for (var element in productsSelling) {
          if ((element.price >= int.parse("${priceFrom}000000") &&
              element.price <= int.parse("${priceTo}000000"))) {
            productsSearch.add(element);
          }
        }
        nameSort = '';
        return;
      }
    }
    //Lấy sản phẩm mới nhất
    if (nameSort == 'Mới nhất') {
      productsAll.clear();
      productsAll.addAll(productsLatest);
    } else if (nameSort == 'Phổ biến') {
      productsAll.clear();
      productsAll.addAll(productsSelling);
    }
    //khi đánh giá đc chọn
    if (star != '-1') {
      if (categoryID == -1) {
        // và nsx ko chọn
        for (var element in productsAll) {
          await ReviewPresenter.instance
              .getProductStar(element, rating)
              .then((value) {
            setState(() {
              check = value;
            });
          });
          setState(() {
            if (check &&
                (element.price >= int.parse("${priceFrom}000000") &&
                    element.price <= int.parse("${priceTo}000000"))) {
              productsSearch.add(element);
            }
            id = -1; //reset giá trị option đang chọn
            nameSort = '';
          });
        }
        return;
      } else {
        for (var element in productsAll) {
          await ReviewPresenter.instance
              .getProductStar(element, rating)
              .then((value) {
            setState(() {
              check = value;
            });
          });
          setState(() {
            if (check &&
                (element.company.companyID == categoryID) &&
                (element.price >= int.parse("${priceFrom}000000") &&
                    element.price <= int.parse("${priceTo}000000"))) {
              productsSearch.add(element);
            }
            id = -1; //reset giá trị option đang chọn
            nameSort = '';
          });
        }
        return;
      }
    }

    //khi cả ba đc chọn
    for (var element in productsAll) {
      setState(() {
        if ((element.company.companyID == categoryID) &&
            (element.price >= int.parse("${priceFrom}000000") &&
                element.price <= int.parse("${priceTo}000000"))) {
          productsSearch.add(element);
        }
        id = -1; //reset giá trị option đang chọn
        nameSort = '';
      });
    }
  }

  //ap dung
  Future<void> applyOption() async {
    await searchsCompanies(categoryID: id, rating: star);
    searchTextController.text = '';
    reslutSearchTextController = '';

    setState(() {
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
      star = '-1';
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
                  getAllProduct();
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
                      productsSearch.clear();
                      checkSuggest = false;
                      return;
                    }
                    if (checkSameData(value)) {
                      checkSuggest = true;
                    } else {
                      productsSearch.clear();
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
                              checkSort: checkSort,
                              checkRate: checkRate,
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