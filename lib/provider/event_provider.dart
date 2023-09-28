// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/event_model.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _eventList = [];
  List<Event> get eventList => _eventList;

  Future<void> fetchEvent() async {
    const url =
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event";


      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['content']['data'];
       
        _eventList = data.map((e) => Event.fromJson(e)).toList();
        notifyListeners();
      } else {
        print("Error in loading event");
      }

  }
}
