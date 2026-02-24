import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PreferenceProvider extends ChangeNotifier {
  final box = Hive.box('preferences');

  void like(int id) {
    box.put(id.toString(), 'like');
    notifyListeners();
  }

  void dislike(int id) {
    box.put(id.toString(), 'dislike');
    notifyListeners();
  }

  String? getPreference(int id) {
    return box.get(id.toString());
  }
  List<int> get likedIds {
    return box.keys
        .where((k) => box.get(k) == 'like')
        .map((e) => int.parse(e))
        .toList();
  }
}