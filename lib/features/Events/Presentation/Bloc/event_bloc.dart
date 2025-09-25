import 'package:bloc/bloc.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Data/repositories/Event_repositories.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc({required this.eventRepository}) : super(EventInitial()) {
    on<AddEventEvent>((event, emit) async {
      emit(EventLoading());
      try {
        final newevent = await eventRepository.createEvent(
          EventModel(
            id: "",
            name: event.eventModel.name,
            venue: event.eventModel.venue,
            Address: event.eventModel.Address,
            date: event.eventModel.date,
            starttime: event.eventModel.starttime,
            endtime: event.eventModel.endtime,
            entryFee: event.eventModel.entryFee,
            offerPrice: event.eventModel.offerPrice,
            availableSlot: event.eventModel.availableSlot,
            imageUrls: eventRepository.imageUrls,
          
            
          )
        
        );

        emit(EventAdded(eventModel: newevent));
      } catch (e) {
        emit(EventError("Failed to add event"));
      }
    });

    on<getEvents>((event, emit) async {
      emit(EventLoading());
      try {
        final events = await eventRepository.getEvents();
        emit(EventFetched(events));
        print("EVENT $events ");
      } catch (e) {
        emit(EventError("Failed to fetch events"));
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
      emit(EventLoading());

      try {
        await eventRepository.deleteEvents(event.eventid);
        final events = await eventRepository.getEvents();
        emit(EventFetched(events));
      } catch (e) {
        emit(EventError("Event does not deleted"));
      }
    });
  }
}
