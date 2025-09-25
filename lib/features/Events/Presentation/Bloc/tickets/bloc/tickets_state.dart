part of 'tickets_bloc.dart';

class TicketsState {}

final class TicketsInitial extends TicketsState {}

class TicketLoading extends TicketsState {}

class TicketExists extends TicketsState {
  final String paymentId;
  final String eventTitle;
  final int attendees;

  TicketExists({
    required this.paymentId,
    required this.eventTitle,
    required this.attendees,
  });
}

class TicketNotExists extends TicketsState {}

class TicketSaved extends TicketsState {
  final String paymentId;
  final int attendees;

  TicketSaved({required this.paymentId, required this.attendees});
}

class TicketError extends TicketsState {
  final String message;
  TicketError(this.message);
}
