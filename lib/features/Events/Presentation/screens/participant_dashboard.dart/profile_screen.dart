import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/event_creation_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/manage_event.dart';
import 'package:eventivo/features/Events/Presentation/widgets/my_events.dart';
import 'package:eventivo/features/Events/Presentation/widgets/upcoming_events.dart';
import 'package:eventivo/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "https://images.pexels.com/photos/6476783/pexels-photo-6476783.jpeg",
      "https://images.pexels.com/photos/30319116/pexels-photo-30319116.jpeg",
      "https://images.pexels.com/photos/7652058/pexels-photo-7652058.jpeg",
      "https://images.pexels.com/photos/8067828/pexels-photo-8067828.jpeg",
    ];
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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              "assets/images/user.png",
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              overlayColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              onTap: () {
                                ///////// handle the fuction in image /////
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ColorConstant.GradientColor1,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      Text(
                        "Sarah Johnson",
                        style: TextStyle(
                          fontFamily: CustomFontss.fontFamily,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 6),
                      Text(
                        "sarah.johnson@email.com",
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
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: CustomFontss.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 18),
                ///////////// UPCOMING EVENTS /////////////
                //////////////// UPCOMING EVENTS /////////////
                ...List.generate(2, (index) => UpcomingEvent()),
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
                    if (state is EventFetched) {
                      return Column(
                        children:
                            ////////////// MY EVENT ///////////////////
                            ///////////// MY EVENT ///////////////////
                            List.generate(
                              state.Events.length,
                              (index) => My_Events(
                                title: state.Events[index].name,
                                URL: state.Events[index].imageUrls[0],
                                date: state.Events[index].date,
                                time: state.Events[index].starttime,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ManageEvent(
                                      eventId: state.Events[index].id,
                                      itemcount:
                                          state.Events[index].imageUrls.length,
                                      imageUrls: state.Events[index].imageUrls,
                                      title: state.Events[index].name,
                                      URL: state.Events[index].imageUrls[1],
                                      AvailableSlote:
                                          state.Events[index].availableSlot,
                                      Entryfee: state.Events[index].entryFee,
                                      location: state.Events[index].venue,
                                      // imageUrl: images[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      );
                    }
                    return Text("no event registered");
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
