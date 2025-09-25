part of 'tickets_bloc.dart';

abstract class TicketsEvent {}



class CheckTicket extends TicketsEvent {
  final String eventId;
  final String userId;
  final String eventTitle;

  CheckTicket({
    required this.eventId,
    required this.userId,
    required this.eventTitle,
  });
}


class SaveTicketEvent extends TicketsEvent {
  final String eventId;
  final String userId;
  final String paymentId;
  final int attendees;
  final String eventTitle;
  final String qrUrl;

  SaveTicketEvent({
    required this.eventId,
    required this.userId,
    required this.paymentId,
    required this.attendees,
    required this.eventTitle,
    required this.qrUrl,
  });
}

