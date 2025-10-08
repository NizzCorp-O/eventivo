import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/programs/bloc/programs_bloc.dart';
import 'package:eventivo/features/Events/Presentation/widgets/container_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatefulWidget {
  final EventModel events;
  final List<String> imageUrls;
  final String coverphoto;

  final String eventName;
  final String date;
  final String starttime;
  final String endtime;
  final String venue;
  final String address;
  final void Function()? onJoin;
  final void Function()? onTicket;
  final void Function()? onChat;

  const EventDetailScreen({
    super.key,
    required this.coverphoto,

    required this.eventName,
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.imageUrls,
    required this.venue,
    required this.address,
    required this.events,
    required this.onJoin,
    this.onChat,
    this.onTicket,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool favorite = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProgramsBloc>(
      context,
    ).add(GetProgramsEvent(widget.events.id));
  }

  @override
  Widget build(BuildContext context) {
    DateTime eventDate = DateFormat('dd MMM yyyy').parse(widget.date);

    String formattedDate = DateFormat('MMMM dd yyyy').format(eventDate);

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      //////// APP BAR  SECTION //////////////
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: Center(
          child: Text(
            "Event Details",
            style: TextStyle(
              fontFamily: CustomFontss.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  favorite = !favorite;
                });
              },
              child: Icon(
                Icons.favorite,
                size: 28,
                color: favorite ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      //////////////////////// BODY SECTION ///////////////////
      //////////////////////// BODY SECTION ///////////////////
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 256,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.coverphoto),
                  ),

                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(height: 24),
              Text(
                softWrap: true,
                overflow: TextOverflow.visible,

                widget.eventName,
                style: TextStyle(
                  fontFamily: CustomFontss.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 12),

              ///// DATE AND PLACE SECTION ///////
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber.withOpacity(.1),
                        ),
                        padding: EdgeInsets.all(9),
                        child: Icon(
                          Icons.calendar_today,
                          color: ColorConstant.GradientColor1,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ////// DATE //////
                            Text(
                              formattedDate.toString(),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.visible,

                              style: TextStyle(
                                fontWeight: FontWeight.w500,

                                fontSize: 16,
                                color: Color(0xFF111827),
                              ),
                            ),
                            ///// TIME //////////////
                            /// ///// TIME //////////////
                            Row(
                              children: [
                                Text(
                                  widget.starttime.toString(),
                                  style: TextStyle(
                                    color: ColorConstant.Subtittle,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("to"),
                                SizedBox(width: 10),
                                Text(
                                  widget.endtime.toString(),
                                  style: TextStyle(
                                    color: ColorConstant.Subtittle,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber.withOpacity(.1),
                        ),
                        padding: EdgeInsets.all(9),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: ColorConstant.GradientColor1,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // softWrap: true,
                              // overflow: TextOverflow.ellipsis,
                              widget.venue,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,

                                fontSize: 16,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Text(
                              widget.address,
                              style: TextStyle(
                                color: ColorConstant.Subtittle,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              ////// MEDIA SECTION //////
              SizedBox(height: 24),
              Text(
                "Media Gellery",
                style: TextStyle(
                  fontFamily: CustomFontss.fontFamily,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    widget.imageUrls.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(6),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Container(
                                width: double.infinity,

                                height: 400,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      widget.imageUrls[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 96,
                          width: 96,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.imageUrls[index]),
                            ),

                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Event Programs",
                style: TextStyle(
                  fontFamily: CustomFontss.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),

              BlocBuilder<ProgramsBloc, ProgramsState>(
                builder: (context, state) {
                  if (state is Programloading) {
                    return Text("");
                  }
                  if (state is ProgramsLoaded) {
                    return Column(
                      children: List.generate(
                        state.programs.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ), // subtle border
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.programs[index].title,
                                        style: TextStyle(
                                          fontFamily: CustomFontss.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      state.programs[index].startTime,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.GradientColor1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  state.programs[index].description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  "Duration : ${state.programs[index].duration}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.PrimaryBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Text("no program currently available");
                },
              ),
              SizedBox(height: 17),

              //       BlocListener<TicketsBloc, TicketsState>(
              //         listener: (context, state) {
              //  if (state is TicketSaved) {
              //         Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => QRScreen(
              //           paymentId:
              //           eventTitle: widget.eventName,
              //           attnedees: attendeesCount,
              //         ),
              //       ),
              //     );

              //  }
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 50),
              //           child: Container(
              //             height: 60,
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               color: ColorConstant.PrimaryBlue,
              //               borderRadius: BorderRadius.circular(15),
              //             ),
              //             child: Center(
              //               child: Text(
              //                 "Get ticket",
              //                 style: TextStyle(
              //                   color: ColorConstant.MainWhite,

              //                   fontFamily: CustomFontss.fontFamily,
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 16,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),

              ////////// JION BUTTON SECTION ///////////
              ///////////// JION BUTTON SECTION ///////////
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 5,
                        color: Colors.grey,
                      ),
                    ],

                    color: ColorConstant.PrimaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      minimumSize: Size(double.infinity, 56),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: widget.onTicket,

                    child: Text(
                      "Get Your Ticket",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.MainWhite,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              ContainerButton(title: "Join Event", onPressed: widget.onJoin),
              SizedBox(height: 12),
              ////////////. chat section //////////
              InkWell(
                onTap: widget.onChat,

                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: BoxBorder.all(
                      width: 1,
                      color: ColorConstant.GradientColor1,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_outlined,
                          color: ColorConstant.GradientColor1,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Chat with Coordinators",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.GradientColor1,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
