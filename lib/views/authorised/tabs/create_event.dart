import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../controllers/eventController.dart';
import '../../../models/eventModel.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final FirestoreService firestoreService = FirestoreService();
  XFile? _image;
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _ticketTypeController = TextEditingController();
  final TextEditingController _ticketPriceController = TextEditingController();
  final TextEditingController _numberOfTicketsController =
      TextEditingController();

  final Map<String, double> _ticketPrices = {};

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    _eventLocationController.dispose();
    _ticketTypeController.dispose();
    _ticketPriceController.dispose();
    super.dispose();
  }

  _pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
    } else {
      _image = image;
      setState(() {});
    }
  }

  DateTime _dateTime = DateTime.now();
  _pickDateTime() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (dateTime != null) {
      _dateTime = dateTime;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _eventNameController,
              decoration: const InputDecoration(labelText: 'Event Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _eventDescriptionController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Event Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _eventLocationController,
              decoration: const InputDecoration(labelText: 'Event Location'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ticket Prices:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildTicketPricesList(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ticketTypeController,
                    decoration: const InputDecoration(labelText: 'Ticket Type'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _ticketPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTicketType,
                  child: const Text('Add Ticket'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _numberOfTicketsController,
                    decoration:
                        const InputDecoration(labelText: 'Tickets Available '),
                  ),
                ),
                Expanded(
                    child: TextButton(
                  child: Text(_dateTime.toLocal().toString()),
                  onPressed: () {
                    _pickDateTime();
                  },
                )),
              ],
            ),
            const SizedBox(height: 16),
            _image == null
                ? ElevatedButton(
                    onPressed: () {
                      _pickImage();
                    },
                    child: const Text("Pick image"))
                : Image.file(File(_image!.path)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createEvent,
              child: const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketPricesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _ticketPrices.entries.map((entry) {
        return ListTile(
          title: Text(entry.key),
          subtitle: Text('\$${entry.value.toStringAsFixed(2)}'),
        );
      }).toList(),
    );
  }

  void _addTicketType() {
    String ticketType = _ticketTypeController.text.trim();
    String ticketPrice = _ticketPriceController.text.trim();

    if (ticketType.isNotEmpty && ticketPrice.isNotEmpty) {
      double? price = double.tryParse(ticketPrice);
      if (price != null) {
        setState(() {
          _ticketPrices[ticketType] = price;
          _ticketTypeController.clear();
          _ticketPriceController.clear();
        });
      } else {
        // Show an error message for invalid price
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Invalid Price'),
            content: const Text('Please enter a valid price.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _createEvent() async {
    String eventName = _eventNameController.text.trim();
    String eventDescription = _eventDescriptionController.text.trim();
    String eventLocation = _eventLocationController.text.trim();

    if (eventName.isNotEmpty &&
        eventDescription.isNotEmpty &&
        eventLocation.isNotEmpty &&
        _ticketPrices.isNotEmpty &&
        _image != null) {
      String? imgUrl =
          await FirebaseStorageService().uploadImage(File(_image!.path));
      Event event = Event(
        eventId: const Uuid().v1(),
        hostId: FirebaseAuth.instance.currentUser!.uid,
        name: eventName,
        description: eventDescription,
        dateAndTime: _dateTime,
        location: eventLocation,
        ticketPrices: _ticketPrices,
        availableSeats: int.parse(
          _numberOfTicketsController.text == ''
              ? '0'
              : _numberOfTicketsController.text,
        ),
        imageUrl: imgUrl ?? "",
      );

      firestoreService.createEvent(event).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to create the event. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    } else {
      // Show an error message for incomplete event details.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Incomplete Details'),
          content: const Text(
              'Please enter all required event details and add at least one ticket type.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

class FirebaseStorageService {
  // Method to upload an image to Firebase Cloud Storage.
  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference ref = _storage.ref().child('images/$fileName');

      UploadTask uploadTask = ref.putFile(imageFile);

      String downloadURL = await (await uploadTask).ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
