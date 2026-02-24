import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/history_model.dart';

class HistoryProvider extends ChangeNotifier {
  final box = Hive.box('history');

  void addItem(HistoryItem item) {
    List list = List.from(box.get('items', defaultValue: []));

    if (!list.any((e) => e['url'] == item.url)) {
      list.add(item.toMap());
      box.put('items', list);
      notifyListeners();
    }
  }

  void clear() {
    box.delete('items');
    notifyListeners();
  }

  List<HistoryItem> get items {
    final list = box.get('items', defaultValue: []);
    return list.map<HistoryItem>((e) => HistoryItem.fromMap(e)).toList();
  }
}