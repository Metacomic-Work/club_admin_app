class Event {
  final String eventId;
  final String hostId;
  final String name;
  final String description;
  final DateTime dateAndTime;
  final String location;
  final Map<String, double> ticketPrices;
  final int availableSeats;
  final String imageUrl;

  Event({
    required this.eventId,
    required this.hostId,
    required this.name,
    required this.description,
    required this.dateAndTime,
    required this.location,
    required this.ticketPrices,
    required this.availableSeats,
    required this.imageUrl,
  });
}
