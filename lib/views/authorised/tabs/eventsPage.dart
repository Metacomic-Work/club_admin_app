import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_admin/models/ticketModel.dart';
import 'package:club_admin/views/authorised/tabs/create_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/eventController.dart';
import '../../../models/eventModel.dart';

class EventsScreen extends StatelessWidget {
  final EventController _eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => CreateEventScreen());
        },
      ),
      appBar: AppBar(
        title: const Text('Event Hosting Dashboard'),
      ),
      body: StreamBuilder<List<Event>>(
        stream: _eventController.getEvents(),
        builder: (context, snapshot) {
          
          if (snapshot.hasData) {
            final events = snapshot.data!;

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  event: event,
                  onTap: () => _showEventTickets(context, event.eventId),
                );
              },
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data found'),
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
        stream: _eventController.getEventTickets(eventId),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            final tickets = snapshot.data!;
            if (tickets.isNotEmpty) {
              return TicketList(tickets: tickets);
            } else {
              return const Center(
                child: Text("No tickets are purchased yet!"),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  EventCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          height: 80,
          width: 100,
          child: AspectRatio(
            aspectRatio: 9 / 18,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: event.imageUrl,
            ),
          ),
        ),
        title: Text(
          event.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          event.description,
          maxLines: 2,
        ),
        onTap: onTap,
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  final List<Ticket> tickets;

  TicketList({required this.tickets});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        final personDetails = ticket.personDetails;

        return ListTile(
          title: Text(personDetails[0].name),
          subtitle: Text(personDetails[0].phone),
          trailing: Text('Quantity: ${personDetails.length}'),
          onTap: () => _showTicketDetails(context, ticket),
        );
      },
    );
  }

  void _showTicketDetails(BuildContext context, Ticket ticket) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ticket Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Event ID: ${ticket.eventId}'),
              Text('Ticket ID: ${ticket.ticketId}'),
              Text('Ticket Type: ${ticket.ticketType}'),
              Text('Purchase Date: ${ticket.purchaseDate.toString()}'),
              Text('Total Price: ${ticket.totalPrice}'),
              Text('Person Details:'),
              for (var person in ticket.personDetails)
                ListTile(
                  title: Text('Name: ${person.name}'),
                  subtitle: Text('Phone: ${person.phone}, Gender: ${person.gender}'),
                ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
 