
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/eventModel.dart';
import '../models/ticketModel.dart';

// class  extends GetxController {}

class EventController extends GetxController{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to create a new event in the "events" collection.
  Future<void> createEvent(Event event) {
    return _db.collection('events').doc(event.eventId).set({
      'host_id': event.hostId,
      'name': event.name,
      'description': event.description,
      'date_and_time': event.dateAndTime,
      'location': event.location,
      'ticket_prices': event.ticketPrices,
      'available_seats': event.availableSeats,
      'image_url': event.imageUrl,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  // Method to purchase a ticket and create a new ticket in the "tickets" collection.
  Future<void> purchaseTicket(String eventId, String userId, String ticketType,
      int quantity, double totalPrice, Map<String, dynamic> userDetails) async {
    final batch = _db.batch();

    // Create a new ticket document
    final ticketRef = _db.collection('tickets').doc();
    batch.set(ticketRef, {
      'event_id': eventId,
      'user_id': userId,
      'ticket_type': ticketType,
      'purchase_date': FieldValue.serverTimestamp(),
      'quantity': quantity,
      'total_price': totalPrice,
      'user_details': userDetails,
    });

    // Update available seats in the "events" collection using a transaction
    final eventRef = _db.collection('events').doc(eventId);
    batch.update(eventRef, {
      'available_seats': FieldValue.increment(-quantity),
    });

    await batch.commit();
  }

  // Method to get a list of events from the "events" collection.

  Stream<List<Event>> getEvents() {
    return _db.collection('events').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event(
          eventId: doc.id,
          hostId: doc['host_id'],
          name: doc['name'],
          description: doc['description'],
          dateAndTime: doc['date_and_time'].toDate(),
          location: doc['location'],
          ticketPrices: Map<String, double>.from(doc['ticket_prices']),
          availableSeats: doc['available_seats'],
          imageUrl: doc['image_url'],
        );
      }).toList();
    });
  }

  // Method to get a list of tickets for a specific event from the "tickets" collection.
  Stream<List<Ticket>> getEventTickets(String eventId) {
    return _db
        .collection('tickets')
        .where('event_id', isEqualTo: eventId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        List<PersonDetails> personDetailsList = [];
        if (doc['user_details'] is List) {
          personDetailsList = List<PersonDetails>.from(
              doc['user_details'].map((person) => PersonDetails(
                    name: person['name'],
                    phone: person['phone'],
                    gender: person['gender'],
                  )));
        }

        return Ticket(
          ticketId: doc.id,
          eventId: doc['event_id'],
          userId: doc['user_id'],
          ticketType: doc['ticket_type'],
          purchaseDate: doc['purchase_date'].toDate(),
          totalPrice: doc['total_price'],
          personDetails: personDetailsList,
        );
      }).toList();
    });
  }
}

// description
// add person name,phone ,gender,