import 'package:bloc/bloc.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Data/repositories/Event_repositories.dart';
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
        await eventRepository.createEvent(
          EventModel(
            id: event.eventModel.id,
            name: event.eventModel.name,
            venue: event.eventModel.venue,
            date: event.eventModel.date,
            time: event.eventModel.time,
            entryFee: event.eventModel.entryFee,
            offerPrice: event.eventModel.offerPrice,
            availableSlot: event.eventModel.availableSlot,
            imageUrls: eventRepository.imageUrls,
          ),
        );
        emit(EventAdded());
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
      emit(EventLoading());
      try {
        await eventRepository.pickMedia();
        emit(EventLoaded(images: eventRepository.imageslist));
      } catch (e) {
        // If user cancels, retain exist
        if (e.toString().contains("No image selected")) {
          emit(EventLoaded(images: eventRepository.imageslist));
        } else {
          emit(EventError(e.toString()));
        }
      }
    });
    on<RemoveImageEvent>((event, emit) {
      final currentImages = List<XFile>.from(eventRepository.imageslist);
      if (event.index >= 0 && event.index < currentImages.length) {
        currentImages.removeAt(event.index);
        eventRepository.imageslist = currentImages;
        emit(EventLoaded(images: currentImages));
      }
    });

    // on<UploadImagesEvent>((event, emit) async {
    //   emit(EventLoading());
    //   try {
    //     final urls = await eventRepository.(event.images);
    //     emit(UploadImages(urls));
    //   } catch (e) {
    //     emit(EventError("Failed to upload images"));
    //   }
    // });
    on<PickDate>((event, emit) {
      final formatted = DateFormat('dd MMM yyyy').format(event.date);
      emit(
        EventFormState(
          date: event.date,
          dateString: formatted,
          time: (state is EventFormState)
              ? (state as EventFormState).time
              : null,
          timeString: (state is EventFormState)
              ? (state as EventFormState).timeString
              : null,
          isValid: (state is EventFormState)
              ? (state as EventFormState).time != null
              : false,
        ),
      );
    });
    on<PickTime>((event, emit) {
      final dt = DateTime(0, 0, 0, event.time.hour, event.time.minute);
      final formatted = DateFormat.jm().format(dt);
      emit(
        EventFormState(
          time: event.time,
          timeString: formatted,
          date: (state is EventFormState)
              ? (state as EventFormState).date
              : null,
          dateString: (state is EventFormState)
              ? (state as EventFormState).dateString
              : null,
          isValid: (state is EventFormState)
              ? (state as EventFormState).date != null
              : false,
        ),
      );
    });
    on<ClearDateTime>((event, emit) {
      emit(EventFormState());
    });
  }
}
