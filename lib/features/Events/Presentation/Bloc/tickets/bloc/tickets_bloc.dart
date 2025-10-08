// import 'package:bloc/bloc.dart';
// import 'package:eventivo/features/Events/Data/repositories/tickets_repositories.dart';
// part 'tickets_event.dart';
// part 'tickets_state.dart';

// class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
//   final TicketsRepositories repository;
//   TicketsBloc(this.repository) : super(TicketsInitial()) {
//     on<CheckTicket>((event, emit) async {
//       emit(TicketLoading());
//       try {
//         final exists = await repository.hasTicket(event.eventId, event.userId);
//         if (exists) {
//           final ticket = await repository.getTicket(
//             event.eventId,
//             event.userId,
//           );
//           emit(
//             TicketExists(
//               paymentId: ticket!["paymentId"],
//               eventTitle: ticket["eventTitle"],
//               attendees: ticket["attendees"],
//             ),
//           );
//         } else {
//           emit(TicketNotExists());
//         }
//       } catch (e) {
//         emit(TicketError(e.toString()));
//       }
//     });
//     on<SaveTicketEvent>((event, emit) async {
//       emit(TicketLoading());
//       try {
//         await repository.saveTicket(
//           event.eventId,
//           event.userId,
//           event.paymentId,
//           event.attendees,
//           event.eventTitle,
//           event.qrUrl
//         );
//         emit(TicketSaved(
//           paymentId: event.paymentId,
//            attendees: event.attendees
//         ));
//       } catch (e) {
//         emit(TicketError(e.toString()));
//       }
//     });
//   }
// }
