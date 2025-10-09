import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/event_creation_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/manage_event.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/edit_profile_screen.dart';
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
                      const SizedBox(height: 32),

                      //  PROFILE IMAGE WITH STREAMBUILDER
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircleAvatar(
                              radius: 60,
                              child: Icon(Icons.person, size: 50),
                            );
                          }

                          final userData =
                              snapshot.data!.data() as Map<String, dynamic>?;

                          final profileImage = userData?['profileImage'] ?? "";

                          return Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey.shade100,
                                backgroundImage: profileImage.isNotEmpty
                                    ? NetworkImage(profileImage)
                                    : null,
                                child: profileImage.isEmpty
                                    ? const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.white,
                                      )
                                    : null,
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

                      const SizedBox(height: 20),

                      Text(
                        user?.displayName ?? "Unknown Name",
                        style: TextStyle(
                          fontFamily: CustomFontss.fontFamily,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 6),
                      Text(
                        user?.email ?? "Unverified Email",
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.Subtittle,
                        ),
                      ),

                      const SizedBox(height: 30),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                Text(
                  "Joined Events",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: CustomFontss.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),

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

                const SizedBox(height: 20),

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
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EventCreationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              "Create Event",
                              style: TextStyle(color: Colors.white),
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

                BlocConsumer<EventBloc, EventState>(
                  listener: (context, state) {},
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
                        return Text("");
                      }

                      return Column(
                        children: List.generate(
                          state.myevents.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: My_Events(
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

                                    final entry = int.tryParse(entryFee) ?? 0;
                                    final offer = int.tryParse(offerPrice) ?? 0;

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
                                      URL: state.myevents[index].imageUrls.last,
                                      AvailableSlote:
                                          state.myevents[index].availableSlot,
                                      Entryfee: state.myevents[index].entryFee,
                                      location: state.myevents[index].venue,
                                      totalfee: total.toString(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const Text("Only admin can create Event");
                  },
                ),

                Center(
                  child: InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
