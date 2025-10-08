import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';

import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/program_model.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/programs/bloc/programs_bloc.dart'
    hide PickedStartTime;
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/qr_scanner.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/scanned_tickets_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/particiipant_list_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/bottom_navigation_screen.dart';
import 'package:eventivo/features/Events/Presentation/widgets/program_section.dart';
import 'package:eventivo/features/auth/presentation/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageEvent extends StatefulWidget {
  final String title;
  final String URL;
  final String location;
  final String AvailableSlote;
  final String Entryfee;
  final String offerPrice;
  final List<String> imageUrls;
  final int itemcount;
  final String myeventId;
  final EventModel event;
  final String totalfee;

  const ManageEvent({
    super.key,
    required this.title,
    required this.URL,
    required this.location,
    required this.AvailableSlote,
    required this.Entryfee,
    required this.imageUrls,
    required this.itemcount,
    required this.myeventId,
    required this.event,
    required this.offerPrice,
    required this.totalfee,
  });

  @override
  State<ManageEvent> createState() => _ManageEventState();
}

class _ManageEventState extends State<ManageEvent> {
  List<ProgramModel> programsList = [];

  @override
  void initState() {
    super.initState();
    context.read<ProgramsBloc>().add(GetProgramsEvent(widget.myeventId));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController programnController = TextEditingController();
    TextEditingController durationController = TextEditingController();
    TextEditingController starttimepgmController = TextEditingController();
    TextEditingController endtimepgmController = TextEditingController();
    TextEditingController progrmDescController = TextEditingController();
    TextEditingController venueController = TextEditingController(
      text: widget.location,
    );
    TextEditingController availableSlotController = TextEditingController(
      text: widget.AvailableSlote,
    );

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstant.MainWhite,
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: CustomFontss.fontFamily),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cover Photo",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.URL.isNotEmpty
                              ? widget.URL
                              : "https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg",
                        ),
                      ),
                      color: Colors.grey.shade100,

                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 192,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF3F4F6).withOpacity(.5),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.MainWhite,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16), // simpler padding
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorConstant
                                      .GradientColor1.withOpacity(.1),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.groups_2,
                                  color: ColorConstant.GradientColor1,
                                ),
                              ),
                              const SizedBox(height: 9),
                              const Text(
                                "32",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 9),
                              const Text(
                                "Participants",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.MainWhite,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green.withOpacity(.2),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.currency_rupee,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 9),
                              const Text(
                                "₹2,500",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 9),
                              const Text(
                                "Total revenue",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScannedTickets()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 17),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,

                        color: Colors.black.withOpacity(.5),
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: ColorConstant.GradientColor1,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.MainWhite.withOpacity(.2),
                        ),
                        padding: EdgeInsets.all(21),
                        child: Icon(
                          Icons.qr_code,
                          color: ColorConstant.MainWhite,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Scan Ticket",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.MainWhite,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            "Tap to scan QR code",
                            style: TextStyle(
                              color: ColorConstant.MainWhite,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 29),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Media Gallery",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: CustomFontss.fontFamily,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorConstant.GradientColor1,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: ColorConstant.MainWhite),
                        SizedBox(width: 10),
                        Text(
                          "Add Media",
                          style: TextStyle(
                            fontFamily: CustomFontss.fontFamily,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is MyEventFetched) {
                    return Column(
                      children: [
                        GridView.builder(
                          itemCount: widget.itemcount,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                mainAxisExtent: 148,
                                crossAxisCount: 2,
                              ),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.imageUrls[index]),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade100,
                              ),
                              // height: 90,
                              // width: 100,
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return Text("no medias");
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding:  EdgeInsets.all(16),

              ///////////////  PROGRAM SECTION /////////////
              ///////////////  PROGRAM SECTION /////////////
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Event Programs",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: CustomFontss.fontFamily,
                    ),
                  ),
                  /////////.   Add Program Section ////////
                  /// /////.   Add Program Section ////////
                  InkWell(
                    onTap: () {
                      alert_dailoque(
                        endtimeController: endtimepgmController,
                        starttimeController: starttimepgmController,
                        isEdit: false,
                        programId: "",
                        context: context,
                        programnController: programnController,
                        progrmDescController: progrmDescController,
                        durationController: durationController,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorConstant.GradientColor1,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: ColorConstant.MainWhite),
                          SizedBox(width: 10),
                          Text(
                            "Add Programs",
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<ProgramsBloc, ProgramsState>(
                    listener: (context, state) {
                      if (state is Programloading) {
                        Center(child: Text("Program is Loading.."));
                      }
                    },
                    builder: (context, state) {
                      if (state is ProgramsLoaded) {
                        return ReorderableListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.programs.length,
                          onReorder: (oldIndex, newIndex) {
                            context.read<ProgramsBloc>().add(
                              ReorderEvents(
                                ID: widget.myeventId,
                                oldIndex: oldIndex,
                                newIndex: newIndex,
                              ),
                            );
                          },
                          itemBuilder: (context, index) {
                            final program = state.programs[index];
                            return Card(
                              key: ValueKey(
                                program.id,
                              ), // Key is must for reordering
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Program_section(
                                onEdit: () {
                                  alert_dailoque(
                                    endtimeController: TextEditingController(
                                      text: program.endTime,
                                    ),
                                    starttimeController: TextEditingController(
                                      text: program.startTime,
                                    ),
                                    programId: program.id,
                                    context: context,
                                    programnController: TextEditingController(
                                      text: program.title,
                                    ),
                                    progrmDescController: TextEditingController(
                                      text: program.description,
                                    ),
                                    durationController: TextEditingController(
                                      text: program.duration,
                                    ),
                                    isEdit: true,
                                  );
                                },
                                onDelete: () {
                                  context.read<ProgramsBloc>().add(
                                    DeleteProgram(
                                      programid: program.id,
                                      ID: widget.myeventId,
                                    ),
                                  );
                                },
                                programtitle: program.title,
                                programdesc: program.description,
                                starttime: program.startTime,
                                endtime: program.endTime,
                              ),
                            );
                          },
                        );
                      }

                      // fallback state
                      return const Center(child: Text("program loading.."));
                    },
                  ),

                  SizedBox(height: 20),
                  Text(
                    "Venue",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    controller: venueController,
                    validator: (value) => InputValidator.validateVenue(value),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade400,
                      ),
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Enter the location",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Available Slote",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    controller: availableSlotController,
                    validator: (value) => InputValidator.validateVenue(value),
                    decoration: InputDecoration(
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "-",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        "Event Pricing",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: CustomFontss.fontFamily,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorConstant.GradientColor1,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_square,
                              color: ColorConstant.MainWhite,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontFamily: CustomFontss.fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  BlocBuilder<EventBloc, EventState>(
                    builder: (context, state) {
                      if (state is EventFetched) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: BoxBorder.all(
                              width: 1,
                              color: ColorConstant.InputBorder,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Entry Fee",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Text(
                                    widget.Entryfee.isNotEmpty
                                        ? "₹${widget.Entryfee}"
                                        : "₹ 0",

                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Offer Price",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Text(
                                    widget.offerPrice.isNotEmpty
                                        ? "₹${widget.offerPrice}"
                                        : "₹ 0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                              Row(
                                children: [
                                  Text(
                                    "Platform Fee",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\₹0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: ColorConstant.InputBorder,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total per Participant",
                                    style: TextStyle(
                                      fontFamily: CustomFontss.fontFamily,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  Text(
                                    widget.totalfee.isNotEmpty
                                        ? widget.totalfee
                                        : "0",

                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstant.GradientColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return Text("No Pricing");
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: ColorConstant.InputBorder),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Danger Zone",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: CustomFontss.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shadowColor: Colors.white,
                          buttonPadding: EdgeInsets.all(20),
                          backgroundColor: Colors.white,
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Text(
                                    "Are you sure want to delete ?",
                                    style: TextStyle(
                                      fontFamily: CustomFontss.fontFamily,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  BlocBuilder<EventBloc, EventState>(
                                    builder: (context, state) {
                                      if (state is MyEventFetched) {
                                        return InkWell(
                                          onTap: () {
                                            context.read<EventBloc>().add(
                                              DeleteEvents(
                                                eventid: widget.myeventId,
                                              ),
                                            );
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: BoxBorder.all(
                                                width: 1,
                                                color: Colors.red,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: ColorConstant.CancelClr,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Text("data");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.red),
                        color: ColorConstant.CancelClr,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              "Delete Event",
                              style: TextStyle(
                                fontFamily: CustomFontss.fontFamily,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      "This action cannot be undone. All participant data will be lost.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Future<dynamic> alert_dailoque({
    required BuildContext context,
    required TextEditingController programnController,
    required TextEditingController progrmDescController,
    required TextEditingController durationController,
    required TextEditingController starttimeController,
    required TextEditingController endtimeController,
    final bool? isEdit,
    required final String programId,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorConstant.MainWhite,

          // EDIT 1: Move main content from actions -> content
          content: SingleChildScrollView(
            //  EDIT 2: Wrap Column in SingleChildScrollView
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(
                  context,
                ).viewInsets.bottom, //  EDIT 3: Keyboard-safe padding
              ),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, //  EDIT 4: Prevent Column from expanding (overflow fix)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    isEdit == true ? "Edit Program" : "Add Program",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Program Name
                  Text(
                    "Program name",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: programnController,
                    validator: (value) => InputValidator.validateVenue(value),
                    decoration: InputDecoration(
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Enter program name",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Description
                  Text(
                    "Description",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: progrmDescController,
                    validator: (value) => InputValidator.validateVenue(value),
                    decoration: InputDecoration(
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Enter Description",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Duration
                  Text(
                    "Duration",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: durationController,
                    validator: (value) => InputValidator.validateVenue(value),
                    decoration: InputDecoration(
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "1 hour ",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Start time ",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  TextFormField(
                    validator: (value) =>
                        InputValidator.validateStarttime(value),
                    readOnly: true,

                    controller: starttimeController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,

                      hintText: "Start Time",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                      prefixIcon: InkWell(
                        onTap: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final formattedTime = pickedTime.format(
                              context,
                            ); // e.g., "10:30 AM"
                            starttimeController.text = formattedTime;
                            context.read<EventBloc>().add(
                              PickedStartTime(pickedTime),
                            );
                          }
                        },
                        child: Icon(
                          Icons.access_time,
                          color: ColorConstant.GradientColor2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "End time",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  TextFormField(
                    validator: (value) => InputValidator.validateEndTIme(value),
                    readOnly: true,
                    controller: endtimeController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,

                      hintText: "End Time",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                      prefixIcon: InkWell(
                        onTap: () async {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final formattedTime = pickedTime.format(
                              context,
                            ); // e.g., "10:30 AM"
                            endtimeController.text = formattedTime;
                            context.read<EventBloc>().add(
                              PickedEndTime(pickedTime),
                            );
                          }
                        },
                        child: Icon(
                          Icons.access_time,
                          color: ColorConstant.GradientColor2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //  EDIT 5: Use actions for buttons only
          actions: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.CancelClr,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 40,
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      final currentState = context.read<ProgramsBloc>().state;
                      int nextOrder = 0;

                      if (currentState is ProgramsLoaded) {
                        nextOrder = currentState.programs.length;
                      }

                      if (isEdit == true) {
                        context.read<ProgramsBloc>().add(
                          UpdateProgram(
                            widget.myeventId,
                            progrmmodel: ProgramModel(
                              endTime: endtimeController.text,
                              description: progrmDescController.text,
                              duration: durationController.text,
                              startTime: starttimeController.text,

                              id: programId,
                              title: programnController.text,

                              order: nextOrder, // pass current order
                            ),
                          ),
                        );
                      } else {
                        context.read<ProgramsBloc>().add(
                          AddProgramEvent(
                            ID: widget.myeventId,
                            programmodel: ProgramModel(
                              endTime: endtimeController.text,
                              id: "",
                              title: programnController.text.isNotEmpty
                                  ? programnController.text
                                  : "untitled",
                              description: progrmDescController.text,
                              startTime: starttimeController.text,

                              duration: durationController.text,
                              order: programsList.isEmpty
                                  ? 0
                                  : programsList.last.order + 1,
                            ),
                          ),
                        );
                      }

                      programnController.clear();
                      progrmDescController.clear();
                      durationController.clear();
                      starttimeController.clear();
                      endtimeController.clear();
                      Navigator.pop(context);
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.GradientColor1,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 40,
                      child: Center(
                        child: Text(
                          isEdit == true ? "Update" : "Add",
                          style: TextStyle(color: ColorConstant.MainWhite),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
