import 'dart:io' show File;

import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Data/repositories/Event_repositories.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminEventCreationScreen extends StatefulWidget {
  const AdminEventCreationScreen({super.key});

  @override
  State<AdminEventCreationScreen> createState() =>
      _AdminEventCreationScreenState();
}

class _AdminEventCreationScreenState extends State<AdminEventCreationScreen> {
  final EventRepository eventRepository = EventRepository();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Event Title'),
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Event Date'),
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Event Location'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<EventBloc>().add(PickImageEvent());
                },
                child: Text("choose media"),
              ),
              SizedBox(height: 20),

              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    return Text("Image Loading");
                  } else if (state is EventLoaded) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 images per row
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: state.images.length > 5
                          ? 5
                          : state.images.length,
                      itemBuilder: (context, index) {
                        final imageFile = state.images[index];
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(imageFile.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {},
                                // onTap: () => eventRepository.removeImage(index),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Text("No images selected");
                  }
                },
              ),

              SizedBox(height: 20),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    return CircularProgressIndicator();
                  } else if (state is EventError) {
                    return Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      final urls = await eventRepository.uploadImages(
                        eventRepository.imageslist,
                      ); // upload & get urls
                      context.read<EventBloc>().add(
                        AddEventEvent(
                          eventModel: EventModel(
                            imageUrl: urls,
                            id: UniqueKey().toString(),
                            title: _titleController.text,
                            date: _dateController.text,
                            location: _locationController.text,
                          ),
                        ),
                      );
                    },
                    child: Text('Create Event'),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _pickMedia() async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );

  //   if (pickedFile != null) {
  //     final file = File(pickedFile.path);

  //     // unique file name
  //     final fileName = DateTime.now().millisecondsSinceEpoch.toString();

  //     // reference to Firebase Storage
  //     final ref = FirebaseStorage.instance.ref().child(
  //       'event_images/$fileName.jpg',
  //     );

  //     // upload
  //     await ref.putFile(file);

  //     // get download URL
  //     final url = await ref.getDownloadURL();

  //     setState(() {
  //       imageslist.add(XFile(pickedFile.path));
  //       // you may also store urls in another list
  //       // urlsList.add(url);
  //     });

  //     print("Uploaded ✅ URL: $url");
  //   }

  //   if (imageslist.length >= 5) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.blueGrey,
  //         content: Text("Warning: Maximum 5 media allowed"),
  //       ),
  //     );
  //   }
  // }

  // void _removeImage(int index) {
  //   setState(() {
  //     imageslist.removeAt(index);
  //   });
  // }

  // Future<List<String>> _uploadImages() async {
  //   final uploadTasks = imageslist.map((image) async {
  //     final file = File(image.path);

  //     final fileName =
  //         '${DateTime.now().millisecondsSinceEpoch}_${image.hashCode}';
  //     final ref = FirebaseStorage.instance.ref().child(
  //       'event_images/$fileName.jpg',
  //     );

  //     await ref.putFile(file);

  //     return await ref.getDownloadURL();
  //   });

  //   return await Future.wait(uploadTasks);
  // }
}
