class PersonDetails {
  final String name;
  final String phone;
  final String gender;

  PersonDetails({
    required this.name,
    required this.phone,
    required this.gender,
  });
}


class Ticket {
  final String ticketId;
  final String eventId;
  final String userId;
  final String ticketType;
  final DateTime purchaseDate;
  final double totalPrice;
  final List<PersonDetails> personDetails;

  Ticket({
    required this.ticketId,
    required this.eventId,
    required this.userId,
    required this.ticketType,
    required this.purchaseDate,
    required this.totalPrice,
    required this.personDetails,
  });
}
