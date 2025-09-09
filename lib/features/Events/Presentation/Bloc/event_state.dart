part of 'event_bloc.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoaded extends EventState {
  final List<XFile> images;
  final List<String> imageUrls;

  EventLoaded( {required this.images, required this.imageUrls});
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
  final TimeOfDay? starttime;
  final TimeOfDay? endtime;
  final String? dateString;
  final String? starttimeString;
  final String? endtimeString;
  final bool isValid;

  EventFormState({
    this.date,
    this.starttime,
    this.endtime,
    this.dateString,
    this.starttimeString,
    this.endtimeString,
    this.isValid = false,
  });

  // CopyWith method
  EventFormState copyWith({
    DateTime? date,
    TimeOfDay? starttime,
    TimeOfDay? endtime,
    String? dateString,
    String? starttimeString,
    String? endtimeString,
    bool? isValid,
  }) {
    return EventFormState(
      date: date ?? this.date,
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
      dateString: dateString ?? this.dateString,
      starttimeString: starttimeString ?? this.starttimeString,
      endtimeString: endtimeString ?? this.endtimeString,
      isValid: isValid ?? this.isValid,
    );
  }
}

