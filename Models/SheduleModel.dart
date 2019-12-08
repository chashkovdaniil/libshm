import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:schooldiary/Models/Shedule.dart';

class SheduleModel extends ChangeNotifier {
  final List<Shedule> _lessons = [];

  UnmodifiableListView<Shedule> get lessons => UnmodifiableListView(_lessons);

  void add(Shedule shedule) {
    _lessons.add(shedule);
    notifyListeners();
  }
}