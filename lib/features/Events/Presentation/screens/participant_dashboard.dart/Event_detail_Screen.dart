import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/Program_model.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/programs/bloc/programs_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/payment_screen.dart';
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
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProgramsBloc>(
      context,
    ).add(GetProgramsEvent(widget.events.id));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    TextEditingController timeController = TextEditingController();

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
            child: Icon(Icons.favorite_border, size: 28),
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
                                  widget.starttime,
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
                                  widget.endtime,
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
                  fontWeight: FontWeight.w600,
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
              SizedBox(height: 24),
              Text(
                "Event Programs",
                style: TextStyle(
                  fontFamily: CustomFontss.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),

              BlocBuilder<ProgramsBloc, ProgramsState>(
                builder: (context, state) {
                  if (state is Programloading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ProgramsLoaded) {
                    return Column(
                      children: List.generate(
                        state.programs.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            padding: const EdgeInsets.all(16),
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
                                      state.programs[index].time,
                                      style: TextStyle(
                                        fontSize: 14,
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
                                    fontFamily: CustomFontss.fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.Subtittle,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const SizedBox(width: 4),
                                    Text(
                                      "Duration : 60 mins",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
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

              ////////// JION BUTTON SECTION ///////////
              ///////////// JION BUTTON SECTION ///////////
              ContainerButton(
                title: "Join Event",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
              ),
              SizedBox(height: 12),
              ////////////. chat section //////////
              InkWell(
                onTap: () {},
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
