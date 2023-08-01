class Ticket {
  final String ticketId;
  final String eventId;
  final String userId;
  final String ticketType;
  final DateTime purchaseDate;
  final int quantity;
  final double totalPrice;
  final Map<String, dynamic> userDetails;

  Ticket({
    required this.ticketId,
    required this.eventId,
    required this.userId,
    required this.ticketType,
    required this.purchaseDate,
    required this.quantity,
    required this.totalPrice,
    required this.userDetails,
  });
}
