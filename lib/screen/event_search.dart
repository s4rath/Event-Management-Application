// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:event_manage/functions/getsuffix.dart';
import 'package:event_manage/provider/event_details_provider.dart';
import 'package:event_manage/provider/event_provider.dart';
import 'package:event_manage/screen/event_page.dart';
import 'package:flutter/material.dart';
import 'package:event_manage/provider/search_event_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventSearch extends StatefulWidget {
  const EventSearch({super.key, required this.searchProvider});
  final SearchEventProvider searchProvider;
  @override
  State<EventSearch> createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearch> {
  final SearchEventProvider _searchProvider = SearchEventProvider();
  List<dynamic> _searchResults = [];

  void _performSearch(String query) async {
    await _searchProvider.fetchEvent(query);
    setState(() {
      _searchResults = _searchProvider.eventList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> eventsToDisplay = _searchResults.isNotEmpty
        ? _searchResults
        : Provider.of<EventProvider>(context).eventList;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0,
          elevation: 0,
          title: const Text(
            "Search",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.black), 
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          flexibleSpace: Align(
            heightFactor: 250,
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 30, color: Colors.blueAccent),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      onChanged: _performSearch,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 19),
                        hintText: "Type Event Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: eventsToDisplay.length,
        itemBuilder: (context, index) {
          var result = eventsToDisplay[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                final eventDetailProvider =
                    Provider.of<EventDetailsProvider>(context, listen: false);

                eventDetailProvider.setDetails(
                    title: result.title,
                    date_time: result.dateTime,
                    banner_image: result.bannerImage,
                    description: result.description,
                    organiser_icon: result.organiserIcon,
                    organiser_name: result.organiserName,
                    venue_city: result.venueCity,
                    venue_country: result.venueCountry,
                    venue_name: result.venueName);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EventScreen();
                    },
                  ),
                );
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: Colors.black26, width: 0.5),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        result.organiserIcon,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/notfound.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${result.dateTime.day}",
                                      style: const TextStyle(
                                        color: Color(0xFF5669FF),
                                        fontSize:
                                            11, 
                                      
                                      ),
                                    ),
                                    TextSpan(
                                      text: getDaySuffix(result.dateTime.day)
                                          .toUpperCase(), 
                                      style: const TextStyle(
                                        color: Color(0xFF5669FF),
                                        fontSize:
                                            11, 
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          " ${DateFormat.MMM().format(result.dateTime).toUpperCase()} - ${DateFormat.EEEE().format(result.dateTime).toUpperCase()} - ${DateFormat.jm().format(result.dateTime)}",
                                      style: const TextStyle(
                                        color: Color(0xFF5669FF),
                                        fontSize:
                                            11, 
                                      ),
                                    ),
                                  ],
                                ),
                              )

                             
                              ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 26),
                            child: Container(
                              width: 200,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                strutStyle: const StrutStyle(height: 2),
                                text: TextSpan(
                                    text: result.title,
                                    style: GoogleFonts.getFont('Inter',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
