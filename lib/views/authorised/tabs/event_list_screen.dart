import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/eventController.dart';
import '../../../models/eventModel.dart';
import 'ticket_booking_screen.dart';

class EventListScreen extends StatelessWidget {
  final EventController _eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: StreamBuilder<List<Event>>(
        stream: _eventController.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Event> events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(events[index].name),
                  subtitle: Text(events[index].description),
                  onTap: () {
                    Get.to(() => TicketBookingScreen(event: events[index]));
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
