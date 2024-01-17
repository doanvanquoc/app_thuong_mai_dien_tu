import 'package:hive/hive.dart';

part 'history_search.g.dart';

@HiveType(typeId: 0)
class History {
  @HiveField(0)
  late String searchHistory;

  History({required this.searchHistory});
}
