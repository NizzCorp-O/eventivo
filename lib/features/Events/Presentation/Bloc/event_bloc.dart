import 'package:bloc/bloc.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Data/repositories/event_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  List<EventModel> allEvents = [];

  EventBloc({required this.eventRepository}) : super(EventInitial()) {
    on<AddEventEvent>((event, emit) async {
      emit(EventLoading());
      try {
        await eventRepository.createEvent(event.eventModel);

        emit(EventAdded());
      } catch (e) {
        emit(EventError("Failed to add event"));
      }
    });
    on<SearchEventsEvent>((event, emit) {
      final query = event.query.toLowerCase();

      final filtered = allEvents.where((e) {
        return e.name.toLowerCase().contains(query);
      }).toList();

      emit(EventFetched(filtered));
    });

    on<getEvents>((event, emit) async {
      emit(EventLoading());
      try {
        await emit.forEach<List<EventModel>>(
          eventRepository.getEvents(), // 👈 Stream
          onData: (events) {
            allEvents = events;
            return EventFetched(events);
          },
          onError: (_, __) => EventError("Failed to fetch events"),
        );
      } catch (e) {
        emit(EventError("Something went wrong"));
      }
    });
    on<Myevents>((event, emit) async {
      emit(MyEventLoading());

      try {
        await emit.forEach<List<EventModel>>(
          eventRepository.getMyEvents(),
          onData: (myevent) {
            print("Repository fetched: ${myevent.length} events");
            return MyEventFetched(myevent);
          },
          onError: (_, __) => EventError("Failed to fetch events"),
        );
      } catch (e) {
        emit(EventError("Something went wrong"));
      }
    });

    on<PickImageEvent>((event, emit) async {
      emit(ImageLoading());
      try {
        await eventRepository.pickMedia();
        emit(
          EventLoaded(
            images: List<XFile>.from(eventRepository.imageslist),
            imageUrls: List<String>.from(eventRepository.imageUrls),
          ),
        );
      } catch (e) {
        // If user cancels, retain exist
        if (e.toString().contains("No image selected")) {
          emit(
            EventLoaded(
              images: List<XFile>.from(eventRepository.imageslist),
              imageUrls: List<String>.from(eventRepository.imageUrls),
            ),
          );
        } else {
          emit(EventError(e.toString()));
        }
      }
    });

    on<RemoveImageEvent>((event, emit) {
      eventRepository.removeImage(event.index);
      emit(
        EventLoaded(
          images: List<XFile>.from(eventRepository.imageslist),
          imageUrls: List<String>.from(eventRepository.imageUrls),
        ),
      );
    });

    on<PickDate>((event, emit) {
      final formatted = DateFormat('dd MMM yyyy').format(event.date);
      emit(
        EventFormState(
          date: event.date,
          dateString: formatted,
          starttime: (state is EventFormState)
              ? (state as EventFormState).starttime
              : null,
          starttimeString: (state is EventFormState)
              ? (state as EventFormState).starttimeString
              : null,
          endtime: (state is EventFormState)
              ? (state as EventFormState).endtime
              : null,

          isValid: (state is EventFormState)
              ? (state as EventFormState).starttime != null
              : false,
        ),
      );
    });
    on<PickedStartTime>((event, emit) {
      final dt = DateTime(2000, 1, 1, event.time.hour, event.time.minute);
      final formatted = DateFormat.jm().format(dt);

      final previousState = state is EventFormState
          ? state as EventFormState
          : EventFormState();

      emit(
        previousState.copyWith(
          starttime: event.time,
          starttimeString: formatted,
          // Optionally update isValid
          isValid: previousState.date != null,
        ),
      );
    });

    on<PickedEndTime>((event, emit) {
      final dt = DateTime(2000, 1, 1, event.endtime.hour, event.endtime.minute);
      final formatted = DateFormat.jm().format(dt);

      final previousState = state is EventFormState
          ? state as EventFormState
          : EventFormState();

      emit(
        previousState.copyWith(
          endtime: event.endtime,
          endtimeString: formatted,
          // Optionally update isValid
          isValid:
              previousState.date != null && previousState.starttime != null,
        ),
      );
    });

    on<ClearDateTime>((event, emit) {
      emit(EventFormState());
    });

    on<DeleteEvents>((event, emit) async {
      try {
        await eventRepository.deleteEvents(event.eventid);
      } catch (e) {
        emit(EventError("Failed to delete event"));
      }
    });
  }
}
