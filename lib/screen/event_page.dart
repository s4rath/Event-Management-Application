// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:event_manage/provider/event_details_provider.dart';
import 'package:event_manage/widget/read_more.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    final eventDetailsProvider = Provider.of<EventDetailsProvider>(
      context,
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220.0),
        child: AppBar(
          title: const Text("Event Details", style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: IconButton(
                icon: const Icon(Icons.bookmark),
                onPressed: () {},
                color: Colors.white,
              ),
            )
          ],
          flexibleSpace: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      eventDetailsProvider.banner_image,
                    ),
                    fit: BoxFit.cover),
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                // color: Colors.amber,
                padding: const EdgeInsets.only(top: 30),
                height: 84,
                width: 313,
                child: RichText(
                    text: TextSpan(
                  text: eventDetailsProvider.title,
                  style: const TextStyle(
                      fontSize: 35, color: Colors.black, letterSpacing: .4),
                )),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Container(
                  height: 54,
                  width: 51,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: const DecorationImage(
                          image: AssetImage("assets/logo.jpeg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: const TextSpan(
                      text: "The Internet Folks",
                      style: TextStyle(
                          fontSize: 16, color: Colors.black, letterSpacing: .4),
                    )),
                    RichText(
                        text: const TextSpan(
                      text: "Organizer",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Container(
                  height: 51,
                  width: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xff5669FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color(0xff5669FF).withOpacity(0.9),
                    //     // spreadRadius: 3,
                    //     blurRadius: 4,
                    //     // offset: Offset(0, 2), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: const Icon(
                    Icons.calendar_month_sharp,
                    color: Color(0xff5669FF),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                      text:
                          DateFormat('dd MMMM, yyyy').format(eventDetailsProvider.date_time),
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black, letterSpacing: .4),
                    )),
                    RichText(
                        text: TextSpan(
                      text:
                          "${DateFormat('EEEE, h:mma').format(eventDetailsProvider.date_time)} - ",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Container(
                  height: 51,
                  width: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    // image: DecorationImage(
                    //     image: AssetImage("assets/logo.jpeg"),
                    //     fit: BoxFit.cover),
                    color: const Color(0xff5669FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.location_on, color: Color(0xff5669FF)),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                      text: eventDetailsProvider.venue_name,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black, letterSpacing: .4),
                    )),
                    RichText(
                        text: TextSpan(
                      text:
                          "${eventDetailsProvider.venue_city}, ${eventDetailsProvider.venue_country} ",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // height: 100,
              // width: 100,
              // color: Colors.amber,
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: RichText(
                  text: const TextSpan(
                text: "About Event",
                style: TextStyle(
                    fontSize: 16, color: Colors.black, letterSpacing: .4),
              )),
            ),
            Container(
              child: SingleChildScrollView(
                  child: ReadMoreText(
                      fullString: eventDetailsProvider.description)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.transparent,
          height: 80,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  primary: const Color(0xff5669FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Book Now'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),const SizedBox(width: 50,),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
