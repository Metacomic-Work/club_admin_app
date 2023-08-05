import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../controllers/eventController.dart';
import '../../../models/eventModel.dart';
import '../../../models/ticketModel.dart';

class TicketBookingScreen extends StatefulWidget {
  final Event event;

  TicketBookingScreen({required this.event});

  @override
  _TicketBookingScreenState createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  int ticketQuantity = 1;
  String selectedTicketType = '';
  List<PersonDetails> personDetails = [];

  double selectedTicketPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    personDetails = List.generate(ticketQuantity,
        (index) => PersonDetails(name: '', phone: '', gender: ''));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.event.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.event.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.event.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Date and Time: ${widget.event.dateAndTime}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Location: ${widget.event.location}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ticket Prices:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...widget.event.ticketPrices.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                subtitle: Text('Price: ${entry.value}'),
                leading: Radio(
                  value: entry.key,
                  groupValue: selectedTicketType,
                  onChanged: (value) {
                    selectedTicketPrice = entry.value;
                    setState(() {
                      selectedTicketType = value.toString();
                    });
                  },
                ),
              );
            }).toList(),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (ticketQuantity > 1) {
                        ticketQuantity--;
                        personDetails.removeLast();
                      }
                    });
                  },
                ),
                Text(
                  '$ticketQuantity',
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      ticketQuantity++;
                      personDetails
                          .add(PersonDetails(name: '', phone: '', gender: ''));
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'User Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (int i = 0; i < ticketQuantity; i++)
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildPersonDetailsForm(i),
              )),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _bookTicket();
              },
              child: Text(
                  'Book Ticket for ${widget.event.name} at : \$ ${selectedTicketPrice * ticketQuantity} '),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonDetailsForm(int index) {
    if (personDetails.length > index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Text(
            'User ${index + 1}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            initialValue: personDetails[index].name,  
            onChanged: (value) {
              setState(() {
                personDetails[index].name = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
          keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              
              border: OutlineInputBorder(),
            ),
            initialValue: personDetails[index].phone, // Set initial value
            onChanged: (value) {
              setState(() {
                personDetails[index].phone = value;
              });
            },
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                // labelText: 'Gender',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8.0),
              ),
              value: 'male',
              onChanged: (value) {
                setState(() {
                  personDetails[index].gender = value ?? "Male";
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: 'male',
                  child: Text('Male'),
                ),
                const DropdownMenuItem<String>(
                  value: 'female',
                  child: Text('Female'),
                )
              ]),
          const SizedBox(height: 16.0),
        ],
      );
    } else {
      return const SizedBox
          .shrink(); // If the list is not yet populated, return an empty widget
    }
  }

  void _bookTicket() {
    final eventController = Get.find<EventController>();
    eventController.purchaseTicket(Ticket(
        ticketId: const Uuid().v4(),
        eventId: widget.event.eventId,
        userId: FirebaseAuth.instance.currentUser!.uid,
        ticketType: selectedTicketType,
        purchaseDate: DateTime.now(),
        totalPrice: selectedTicketPrice * ticketQuantity,
        personDetails: personDetails));
  }
}
