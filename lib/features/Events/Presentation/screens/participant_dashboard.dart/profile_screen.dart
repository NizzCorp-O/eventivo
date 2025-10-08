import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/event_creation_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/manage_event.dart';
import 'package:eventivo/features/Events/Presentation/widgets/my_events.dart';
import 'package:eventivo/features/Events/Presentation/widgets/upcoming_events.dart';
import 'package:eventivo/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:eventivo/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<EventBloc>().add(Myevents());
    context.read<AuthBlocBloc>().add(FetchJoinedEvents());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String profileUrl = "";
    // String userEmail = "";

    User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.MainWhite,
        appBar: AppBar(
          backgroundColor: ColorConstant.MainWhite,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
              fontFamily: CustomFontss.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(height: 32),
                      BlocConsumer<AuthBlocBloc, AuthBlocState>(
                        listener: (context, state) {
                          if (state is ProfilePickedError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Image picking failed")),
                            );
                          }
                        },
                        builder: (context, state) {
                          File? pickedFile;

                          if (state is ProfileImagePicked) {
                            pickedFile = state.imageFile;
                          }
                          return Stack(
                            children: [
                              BlocBuilder<AuthBlocBloc, AuthBlocState>(
                                builder: (context, state) {
                                  return CircleAvatar(
                                    backgroundColor: ColorConstant.PrimaryBlue,
                                    backgroundImage: pickedFile != null
                                        ? FileImage(pickedFile)
                                        : state is ProfileImageUpdated
                                        ? NetworkImage(state.imageUrl)
                                              as ImageProvider
                                        : null,
                                    child:
                                        pickedFile == null &&
                                            !(state is ProfileImageUpdated)
                                        ? const Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.white,
                                          )
                                        : null,
                                    radius: 60,
                                  );
                                },
                              ),

                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  onTap: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    if (pickedFile != null) {
                                      final file = File(pickedFile.path);
                                      final userId = FirebaseAuth
                                          .instance
                                          .currentUser!
                                          .uid;

                                      // Step 2: Upload & update Firestore
                                      context.read<AuthBlocBloc>().add(
                                        UpdateProfileImageEvent(file, userId),
                                      );
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        ColorConstant.GradientColor1,
                                    child: const Icon(
                                      Icons.image_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: 20),

                      Text(
                        user?.displayName ?? "unknown name",
                        style: TextStyle(
                          fontFamily: CustomFontss.fontFamily,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 6),
                      Text(
                        user?.email ?? "unverified email",
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.Subtittle,
                        ),
                      ),

                      SizedBox(height: 30),

                      SizedBox(
                        width: 180,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.GradientColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "Joined Events",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: CustomFontss.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 18),

                BlocBuilder<AuthBlocBloc, AuthBlocState>(
                  builder: (context, state) {
                    if (state is JoinedEventLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: ColorConstant.GradientColor1,
                          color: ColorConstant.MainBlack,
                        ),
                      );
                    }
                    if (state is JoinedEventsLoaded) {
                      return Column(
                        children: List.generate(state.joinedEvents.length, (
                          index,
                        ) {
                          final joinedevents = state.joinedEvents[index];
                          return UpcomingEvent(
                            eventId: joinedevents.id,
                            title: joinedevents.name,
                            date: joinedevents.date.toString(),
                            imageUlr: joinedevents.imageUrls[0],
                            starttime: joinedevents.startTime,
                          );
                        }),
                      );
                    }
                    return Center(
                      child: Text(
                        "You have not joined any events yet!.",
                        style: TextStyle(
                          color: ColorConstant.InputText,
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),

                ///////////// ADD EVENT SECTION /////////////
                ///////////// ADD EVENT SECTION /////////////
                Row(
                  children: [
                    Text(
                      "My Events",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventCreationScreen(),
                          ),
                        );
                      },

                      //async {
                      //   try {
                      //     final userDoc = await FirebaseFirestore.instance
                      //         .collection('users')
                      //         .doc(FirebaseAuth.instance.currentUser!.uid)
                      //         .get();

                      //     final role = userDoc.data()?['role'] ?? 'participant';

                      //     if (role == "admin") {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => EventCreationScreen(),
                      //         ),
                      //       );
                      //     } else {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text(
                      //             "You don’t have permission to create events",
                      //           ),
                      //         ),
                      //       );
                      //     }
                      //   } catch (e) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text("Something went wrong: $e")),
                      //     );
                      //   }
                      // },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: ColorConstant.MainWhite),
                            SizedBox(width: 5),
                            Text(
                              "Create Event",
                              style: TextStyle(color: ColorConstant.MainWhite),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorConstant.PrimaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                BlocConsumer<EventBloc, EventState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is MyEventLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: ColorConstant.GradientColor1,
                          color: ColorConstant.MainBlack,
                        ),
                      );
                    }
                    if (state is MyEventFetched) {
                      if (state.myevents.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "No Events",
                                style: TextStyle(
                                  color: ColorConstant.GradientColor1,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: CustomFontss.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children:
                            ////////////// MY EVENT ///////////////////
                            ///////////// MY EVENT ///////////////////
                            List.generate(
                              state.myevents.length,
                              (index) => My_Events(
                                title: state.myevents[index].name,
                                URL: state.myevents[index].imageUrls[0],
                                date: state.myevents[index].date,
                                time: state.myevents[index].startTime,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      final entryFee =
                                          state.myevents[index].entryFee;
                                      final offerPrice =
                                          state.myevents[index].offerPrice;

                                      // convert strings safely
                                      final entry = int.tryParse(entryFee) ?? 0;
                                      final offer =
                                          int.tryParse(offerPrice) ?? 0;

                                      // total = entryFee - offerPrice + platformFee
                                      final total = (entry - offer);
                                      return ManageEvent(
                                        offerPrice:
                                            state.myevents[index].offerPrice,
                                        event: state.myevents[index],
                                        myeventId: state.myevents[index].id,
                                        itemcount: state
                                            .myevents[index]
                                            .imageUrls
                                            .length,
                                        imageUrls:
                                            state.myevents[index].imageUrls,
                                        title: state.myevents[index].name,
                                        URL: state
                                            .myevents[index]
                                            .imageUrls
                                            .last,
                                        AvailableSlote:
                                            state.myevents[index].availableSlot,
                                        Entryfee:
                                            state.myevents[index].entryFee,
                                        location: state.myevents[index].venue,
                                        totalfee: total.toString(),
                                        // imageUrl: images[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                      );
                    }
                    return Text("Only admin can create Event");
                  },
                ),

                SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    //////// Logout Button //////
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(-1, 0),
                            ),
                          ],
                          color: ColorConstant.GradientColor1,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
