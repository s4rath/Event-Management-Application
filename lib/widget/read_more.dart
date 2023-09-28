// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String fullString;

  const ReadMoreText({super.key, required this.fullString});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.fullString.length < 400
            ? Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                  widget.fullString,
                   overflow: TextOverflow.fade,
                  style: const TextStyle(fontSize: 18),
                ),
            )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      _showMore
                          ? widget.fullString
                          : widget.fullString.substring(0, 100),
                      maxLines: _showMore ? null : 3,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showMore = !_showMore;
                        });
                      },
                      child: Text(
                        _showMore ? 'Read Less' : 'Read More',
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
