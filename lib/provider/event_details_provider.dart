// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class EventDetailsProvider extends ChangeNotifier {
  String title = '';
  String description = '';
  String banner_image = '';
  DateTime date_time = DateTime(2000);
  String organiser_name = '';
  String organiser_icon = '';
  String venue_name = '';
  String venue_city = '';
  String venue_country = '';

  void setDetails({
    required String title,
    required String description,
    required String banner_image,
    required DateTime date_time,
    required String organiser_name,
    required String organiser_icon,
    required String venue_name,
    required String venue_city,
    required String venue_country,

  }) {
    this.title = title;
    this.description = description;
    this.banner_image = banner_image;
    this.date_time = date_time;
    this.organiser_name = organiser_name;
    this.organiser_icon = organiser_icon;
    this.venue_name = venue_name;
    this.venue_city = venue_city;
    this.venue_country = venue_country;
    notifyListeners();
  }
}