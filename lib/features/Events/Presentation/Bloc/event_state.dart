part of 'event_bloc.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoaded extends EventState {
  final List<XFile> images;

  EventLoaded({required this.images});
}

class EventFetched extends EventState {
  List<EventModel> Events;
  EventFetched(this.Events);
}

class EventLoading extends EventState {}

class EventAdded extends EventState {}

class EventError extends EventState {
  final String message;

  EventError(this.message);
}

class UploadImages extends EventState {
  final List<String> urls;
  UploadImages(this.urls);
}

class EventFormState extends EventState {
  final DateTime? date;
  final TimeOfDay? time;
  final String? dateString;
  final String? timeString;
  final bool isValid;

  EventFormState({
    this.date,
    this.time,
    this.dateString,
    this.timeString,
    this.isValid = false,
  });

  EventFormState copyWith({
    DateTime? date,
    TimeOfDay? time,
    String? dateString,
    String? timeString,
    bool? isValid,
  }) {
    return EventFormState(
      date: date ?? this.date,
      time: time ?? this.time,
      dateString: dateString ?? this.dateString,
      timeString: timeString ?? this.timeString,
      isValid: isValid ?? this.isValid,
    );
  }
}
