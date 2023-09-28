import 'package:event_manage/provider/event_details_provider.dart';
import 'package:event_manage/provider/event_provider.dart';
import 'package:event_manage/provider/search_event_provider.dart';
import 'package:event_manage/screen/event_home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventDetailsProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => SearchEventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Event Management',
      home: EventHome(),
    );
  }
}
