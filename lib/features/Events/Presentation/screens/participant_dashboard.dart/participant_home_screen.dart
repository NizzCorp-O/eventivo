import 'dart:ffi';

import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/constants/sizedBox/App_spaces.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/repositories/tickets_repositories.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/payment_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/ticket_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/event_detail_Screen.dart';
import 'package:eventivo/features/Events/Presentation/widgets/event_card.dart';
import 'package:eventivo/features/Events/Presentation/widgets/event_widgets/filtered_events.dart';
import 'package:eventivo/features/chat/presentation/screens/message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipantHomeScreen extends StatefulWidget {
  const ParticipantHomeScreen({super.key});

  @override
  State<ParticipantHomeScreen> createState() => _ParticipantHomeScreenState();
}

class _ParticipantHomeScreenState extends State<ParticipantHomeScreen> {
  void initState() {
    super.initState();
    context.read<EventBloc>().add(getEvents());
  }

  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    TicketsRepositories ticketrepo = TicketsRepositories();
    final User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.MainWhite,
        body: RefreshIndicator(
          backgroundColor: ColorConstant.MainWhite,
          color: ColorConstant.GradientColor1,
          onRefresh: () async {
            context.read<EventBloc>().add(getEvents()); // your event to reload
            await Future.delayed(const Duration(seconds: 1));
          },
          child: CustomScrollView(
            slivers: [
              ///////. APP BAR /////////
              /// ///////. APP BAR /////////
              //////////. APP BAR /////////
              SliverAppBar(
                backgroundColor: ColorConstant.MainWhite,
                expandedHeight: 100,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 24),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "Events",
                                style: TextStyle(
                                  fontFamily: CustomFontss.fontFamily,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: ColorConstant.MainBlack,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Discover amazing events near you",
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: ColorConstant.MainBlack,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 24,
                              top: 6,
                              bottom: 6,
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 44,
                                width: 44,

                                child: Center(
                                  child: Icon(
                                    Icons.notifications_none_outlined,
                                    color: ColorConstant.MainWhite,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [
                                      ColorConstant.GradientColor1,
                                      ColorConstant.GradientColor2,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 24),
                      TextField(
                        onChanged: (value) {
                          context.read<EventBloc>().add(
                            SearchEventsEvent(query: value),
                          );
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorConstant.InputText,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: ColorConstant.InputBorder,
                            ),
                          ),
                          hintText: 'Search Events..',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstant.InputBorder,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: ColorConstant.InputText,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      /////// EVENT FILTERING SECTION ///////
                      //////// EVENT FILTERING SECTION //////
                      /////////// EVENT FILTERING SECTION ////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilteredContainer(
                            onTap: () {
                              setState(() {
                                selectedindex = 0;
                                context.read<EventBloc>().add(getEvents());
                              });
                            },
                            tittle: "All",
                            selectedindex: selectedindex == 0,
                            icons: Icons.today_outlined,
                          ),

                          FilteredContainer(
                            onTap: () {
                              setState(() {
                                context.read<EventBloc>().add(getEvents());
                                selectedindex = 1;
                              });
                            },
                            icons: Icons.calendar_today_rounded,
                            tittle: "This Week",
                            selectedindex: selectedindex == 1,
                          ),

                          FilteredContainer(
                            onTap: () {
                              setState(() {
                                context.read<EventBloc>().add(getEvents());
                                selectedindex = 2;
                              });
                            },
                            tittle: "Filter",
                            selectedindex: selectedindex == 2,
                            icons: Icons.filter_list_rounded,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              ////// EVENT CARD SECTION ////////
              ///////// EVENT CARD SECTION //////
              ///////// EVENT CARD SECTION ////////gi
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoading) {
                    return SliverFillRemaining(
                      hasScrollBody: false, // ensures it takes full height
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorConstant.GradientColor1,
                          backgroundColor: ColorConstant.MainBlack,
                        ),
                      ),
                    );
                  } else if (state is EventFetched) {
                    if (state.Events.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: Text("No data")),
                      );
                    }
                    return SliverList.separated(
                      itemCount: state.Events.length,
                      itemBuilder: (context, index) {
                        final event = state.Events[index];
                        return EventCard(
                          URL: event.imageUrls[0],
                          date: event.date,
                          time: event.startTime,
                          venue: event.venue,
                          Eventname: event.name,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailScreen(
                                  onTicket: () async {
                                    final ticketData = await ticketrepo
                                        .getTicket(event.id, user!.uid);
                                    if (ticketData != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TicketScreen(
                                            paymentId:
                                                ticketData['paymentId'] ?? "",
                                            eventTitle:
                                                ticketData['eventTitle'] ?? "",
                                            attnedees:
                                                ticketData['attendees'] ?? 0,
                                            qurl: ticketData['qrUrl'] ?? "",
                                            user: user!.email.toString(),
                                          ),
                                        ),
                                      );
                                    } else if (ticketData == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              ColorConstant.PrimaryBlue,
                                          content: Text(
                                            "Please join the events",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  coverphoto: event.imageUrls[0],
                                  events: event,
                                  date: event.date,
                                  endtime: event.endTime,
                                  starttime: event.startTime,
                                  eventName: event.name,
                                  venue: event.venue,
                                  address: event.address,
                                  imageUrls: event.imageUrls,

                                  onJoin: () async {
                                    final ticketData = await ticketrepo
                                        .getTicket(event.id, user!.uid);
                                    if (ticketData == null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentScreen(
                                            eventid: event.id,
                                            title: event.name,
                                            date: event.date,
                                            starttime: event.startTime,
                                            venue: event.venue,
                                            price: event.entryFee,
                                            Url: event.imageUrls.last,
                                          ),
                                        ),
                                      );
                                    } else if (ticketData != null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              ColorConstant.GradientColor1,
                                          content: Text(
                                            "You already joined the event",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  onChat: () async {
                                    final ticketData = await ticketrepo
                                        .getTicket(event.id, user!.uid);
                                    if (ticketData != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MessageScreen(
                                            eventId: event.id,
                                            eventTitle: event.name,
                                            currentUser: FirebaseAuth
                                                .instance
                                                .currentUser!
                                                .uid,
                                            profileUrl: "",
                                          ),
                                        ),
                                      );
                                    } else if (ticketData == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              ColorConstant.PrimaryBlue,
                                          content: Text(
                                            "Chat is available only after you join the event",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => AppSpaces.height16,
                    );
                  }

                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "no events",
                        style: TextStyle(
                          color: ColorConstant.GradientColor1,
                          fontFamily: CustomFontss.fontFamily,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
