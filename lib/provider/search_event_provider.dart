import 'dart:convert';

import 'package:event_manage/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchEventProvider extends ChangeNotifier {
  List<dynamic> _eventList = [];
  List<dynamic> get eventList => _eventList;

  Future<void> fetchEvent(String keyword) async {
    final url =
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event?search=$keyword";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['content']['data'];
        _eventList = data.map((e) => Event.fromJson(e)).toList();
      notifyListeners();
    } else {
    }
  }
}
