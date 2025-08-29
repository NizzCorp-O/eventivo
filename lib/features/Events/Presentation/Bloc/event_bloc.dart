import 'package:bloc/bloc.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Data/repositories/Event_repositories.dart';
import 'package:image_picker/image_picker.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

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
    on<PickImageEvent>((event, emit) async {
      emit(EventLoading());
      try {
        await eventRepository.pickMedia();
        emit(EventLoaded(images: eventRepository.imageslist));
      } catch (e) {
        emit(EventError("No image selected"));
      }
    });
    on<UploadImagesEvent>((event, emit) async {
      emit(EventLoading());
      try {
        final urls = await eventRepository.uploadImages(event.images);
        emit(UploadImages(urls));
      } catch (e) {
        emit(EventError("Failed to upload images"));
      }
    });
  }
}
