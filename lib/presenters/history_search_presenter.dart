import 'package:app_thuong_mai_dien_tu/models/history_search.dart';
import 'package:hive/hive.dart';

class HistorySearchPresenter {
  static var historiesBox = Hive.box<History>('history');

  static void addHistoryLocal({
    String value = '',
    required List historyLst,
    required List historyLstReversed,
  }) {
    final his = History(searchHistory: value);

    int index = 0;
    for (var element in historyLst) {
      if (element.toString() == value.toString()) {
        historiesBox.deleteAt(index);
        historiesBox.add(his);
        loadHistoryLocal(
            historyLst: historyLst, historyLstReversed: historyLstReversed);
        return;
      }
      index += 1;
    }

    if (value.isEmpty) {
      return;
    }

    historiesBox.add(his); //thêm vào local
    loadHistoryLocal(
        historyLst: historyLst, historyLstReversed: historyLstReversed);
  }

  static void loadHistoryLocal({
    required List historyLst,
    required List historyLstReversed,
  }) {
    historyLst.clear();
    historyLstReversed.clear();
    for (var element in historiesBox.values) {
      historyLst.add(element.searchHistory);
    }
    historyLstReversed.addAll(historyLst.reversed);
  }
}




// //LƯU LOCAL
//   var historiesBox = Hive.box<History>('history');

//   void addHistoryLocal(String value) {
//     final his = History(searchHistory: value);

//     int index = 0;
//     for (var element in historyLst) {
//       if (element.toString() == value.toString()) {
//         historiesBox.deleteAt(index);
//         historiesBox.add(his);
//         loadHistoryLocal();
//         historyLstReversed.clear();
//         historyLstReversed.addAll(historyLst.reversed);
//         return;
//       }
//       index += 1;
//     }

//     if (value.isEmpty) {
//       return;
//     }

//     historiesBox.add(his); //thêm vào local
//     loadHistoryLocal();
//     historyLstReversed.clear(); //làm trống
//     historyLstReversed.addAll(historyLst.reversed); //đảo ngược
//   }

  // void loadHistoryLocal() {
  //   historyLst.clear();
  //   for (var element in historiesBox.values) {
  //     historyLst.add(element.searchHistory);
  //     // print(element.searchHistory);
  //   }
  // }
//   ////////