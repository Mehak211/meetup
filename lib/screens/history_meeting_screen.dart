import 'dart:math';

import 'package:faker/faker.dart'; // Import the faker package
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final faker = Faker(); // Create an instance of the Faker class

    return ListView.builder(
      itemCount: 5, // Generate three random meetings
      itemBuilder: (context, index) {
        // Generate random room name and joined date
        var random = Random();
        final roomName = (random.nextInt(10000000) + 10000000).toString();
        final joinedDate = faker.date.dateTime(minYear: 2024, maxYear: 2024);

        return ListTile(
          title: Text(
            'Room Name: $roomName',
          ),
          subtitle: Text(
            'Joined on ${DateFormat.yMMMd().format(joinedDate)}',
          ),
        );
      },
    );
  }
}
/*return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              'Room Name: ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
            ),
            subtitle: Text(
              'Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
            ),
          ),
        );*/