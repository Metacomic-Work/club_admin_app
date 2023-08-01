import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_admin/models/ticketModel.dart';
import 'package:club_admin/views/authorised/tabs/create_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/eventController.dart';
import '../../../models/eventModel.dart';

class EventHostingUserUI extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => CreateEventScreen());
          }),
      appBar: AppBar(
        title: const Text('Event Hosting Dashboard'),
      ),
      body: StreamBuilder<List<Event>>(
        stream: firestoreService.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  child: ListTile(
                    leading: SizedBox(
                        height: 80,
                        width: 100,
                        child: AspectRatio(
                            aspectRatio: 9 / 18,
                            child: CachedNetworkImage(
                                fit: BoxFit.cover, imageUrl: event.imageUrl))),
                    title: Text(event.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    subtitle: Text(
                      event.description,
                      maxLines: 2,
                    ),
                    onTap: () => _showEventTickets(context, event.eventId),
                  ),
                );
              },
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('Nodata found'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _showEventTickets(BuildContext context, String eventId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StreamBuilder<List<Ticket>>(
        stream: firestoreService.getEventTickets(eventId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tickets = snapshot.data!;
            if (tickets.isEmpty) {
              return const Center(
                child: Text("No tickets are purchased at!"),
              );
            }
            return ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                final personDetails = ticket.personDetails;

                return ListTile(
                  
                  title: Text(personDetails[0].name),
                  subtitle: Text(personDetails[0].phone),
                  trailing: Text('Quantity: ${personDetails.length}'),
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
