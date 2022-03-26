import 'package:flutter/material.dart';

class TemplateProvider extends ChangeNotifier {
  //♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️ Polls Variables ♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️//
  List<List> pollsOptions = [
    ['', '']
  ];
  List<Map> pollsWeights = [{}];
  List<String> pollsTitle = [];
  bool showPollsWidget = false;
  //♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️ Polls Variables ♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️//

  //♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️ POLLS FUNCTIONS ♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️//

  addPollOptions(List value) {
    pollsOptions.add(value);
    notifyListeners();
  }

  addPollWeights(Map value) {
    pollsWeights.add(value);
    notifyListeners();
  }

  addPollTitle(String value) {
    pollsTitle.add(value);
    notifyListeners();
  }

  addPollOptionIndex(int pollIndex) {
    pollsOptions[pollIndex].add('');
    notifyListeners();
  }

  removePollOptions(int index) {
    pollsOptions.removeAt(index);
    notifyListeners();
  }

  removePollWeights(int index) {
    pollsWeights.removeAt(index);
    notifyListeners();
  }

  removePollOptionsAtIndex(int pollIndex, int optionIndex) {
    pollsOptions[pollIndex].removeAt(optionIndex);
    notifyListeners();
  }
}
