// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:event_manage/provider/event_details_provider.dart';
import 'package:event_manage/provider/event_provider.dart';
import 'package:event_manage/provider/search_event_provider.dart';
import 'package:event_manage/screen/event_page.dart';
import 'package:event_manage/screen/event_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventHome extends StatefulWidget {
  const EventHome({
    super.key,
  });

  @override
  State<EventHome> createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  Future<void> apiCall() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    await eventProvider.fetchEvent();
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searcheventProvider =
        Provider.of<SearchEventProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0,
          elevation: 0,
          title: const Text("Events", style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EventSearch(
                    searchProvider: searcheventProvider,
                  );
                }));
              },
              icon: const Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Colors.black),
            )
          ],
        ),
        body: FutureBuilder(
            future: apiCall(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading data'),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ListView.builder(
                          // physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 100.0),
                          shrinkWrap: true,
                          itemCount: Provider.of<EventProvider>(context)
                              .eventList
                              .length,
                          itemBuilder: ((context, index) {
                            final eventItem =
                                Provider.of<EventProvider>(context)
                                    .eventList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  final eventDetailProvider =
                                      Provider.of<EventDetailsProvider>(context,
                                          listen: false);

                                  eventDetailProvider.setDetails(
                                      title: eventItem.title,
                                      date_time: eventItem.dateTime,
                                      banner_image: eventItem.bannerImage,
                                      description: eventItem.description,
                                      organiser_icon: eventItem.organiserIcon,
                                      organiser_name: eventItem.organiserName,
                                      venue_city: eventItem.venueCity,
                                      venue_country: eventItem.venueCountry,
                                      venue_name: eventItem.venueName);

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
                                    border: Border.all(
                                        color: Colors.black26, width: 0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Image.network(
                                          eventItem.organiserIcon,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object error,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    text:
                                                        "${DateFormat.E().format(eventItem.dateTime)}, ${DateFormat('MMM').format(eventItem.dateTime)} ${eventItem.dateTime.day.toString()} ${DateFormat.jm().format(eventItem.dateTime)}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF5669FF)),
                                                  ),
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 24),
                                              child: Container(
                                                width: 200,
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  text: TextSpan(
                                                      text: eventItem.title,
                                                      style:
                                                          GoogleFonts.getFont(
                                                              'Inter',
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14)),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 16,
                                                ),
                                                Container(
                                                  child: RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textScaleFactor: 0.8,
                                                    softWrap: true,
                                                    text: TextSpan(
                                                      text:
                                                          "${eventItem.venueName} \u2022 ${eventItem.venueCity}",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
