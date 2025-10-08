import 'dart:io';

import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/constants/sizedBox/App_spaces.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Data/repositories/event_repositories.dart';

import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';

import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/bottom_navigation_screen.dart';
import 'package:eventivo/features/Events/Presentation/widgets/event_create_media_section.dart';
import 'package:eventivo/features/auth/presentation/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class EventCreationScreen extends StatelessWidget {
  const EventCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    EventRepository eventrepo = EventRepository();
    TextEditingController nameController = TextEditingController();
    TextEditingController venueController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController starttimeController = TextEditingController();
    TextEditingController endtimeController = TextEditingController();
    TextEditingController entryFeeController = TextEditingController();
    TextEditingController offerPriceController = TextEditingController();
    TextEditingController availableSloteController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        centerTitle: true,
        title: Text(
          "Create Event",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Event Details Card ----------------
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpaces.height16,
                    Text(
                      "Event tittle",
                      style: TextStyle(
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpaces.height7,

                    // Event Name
                    TextFormField(
                      validator: (value) =>
                          InputValidator.validateEventName(value),
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: ColorConstant.textfieldBG,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Enter event name",
                        hintStyle: TextStyle(color: ColorConstant.InputText),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstant.InputBorder,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    AppSpaces.height21,
                    Text(
                      "Event venue",
                      style: TextStyle(
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpaces.height7,

                    ////////////////////// EVENT VENUE ///////////////////////////
                    ///////////////////////// EVENT VENUE ////////////////////////
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
                    AppSpaces.height21,
                    Text(
                      "Details of Address",
                      style: TextStyle(
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSpaces.height7,

                    /////////////////////// VENUE TEXT FORM FIELD //////////////////
                    ///////////////////////// VENUE TEXT FORM FIELD //////////////////
                    TextFormField(
                      validator: (value) =>
                          InputValidator.validateAddress(value),
                      controller: addressController,
                      decoration: InputDecoration(
                        fillColor: ColorConstant.textfieldBG,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Address",
                        hintStyle: TextStyle(color: ColorConstant.InputText),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstant.InputBorder,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    AppSpaces.height21,

                    ////////////////////////////////////// DATE AND START TIME //////////////////////////////////////////
                    BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
                        if (state is EventFormState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            dateController.text = state.dateString ?? "";
                            starttimeController.text =
                                state.starttimeString ?? "";
                            endtimeController.text = state.endtimeString ?? "";
                          });
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<EventBloc, EventState>(
                                builder: (context, state) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date",
                                        style: TextStyle(
                                          fontFamily: CustomFontss.fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      AppSpaces.height7,
                                      ///////////////////////////////// DATE FORM FIELD //////////////
                                      /////////////////////////////////////////////////////////////////
                                      TextFormField(
                                        validator: (value) =>
                                            InputValidator.validateDate(value),
                                        controller: dateController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          fillColor: ColorConstant.textfieldBG,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConstant.InputBorder,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),

                                          hintText: "Date",
                                          hintStyle: TextStyle(
                                            color: ColorConstant.InputText,
                                          ),
                                          prefixIcon: InkWell(
                                            onTap: () async {
                                              final pickedDate =
                                                  await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100),
                                                  );
                                              if (pickedDate != null) {
                                                dateController.text =
                                                    DateFormat(
                                                      "dd MMM yyyy",
                                                    ).format(
                                                      pickedDate,
                                                    ); // intl package
                                                context.read<EventBloc>().add(
                                                  PickDate(pickedDate),
                                                );
                                              }
                                            },
                                            child: Icon(
                                              Icons.calendar_today,
                                              color:
                                                  ColorConstant.GradientColor2,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            AppSpaces.height21,
                            AppSpaces.width10,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Start time",
                                    style: TextStyle(
                                      fontFamily: CustomFontss.fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  AppSpaces.height7,
                                  ///////////////////// START TIME  TEXT FIELD /////////////////////////////
                                  /// ///////////////////// START TIME /////////////////////////////
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
                                      hintStyle: TextStyle(
                                        color: ColorConstant.InputText,
                                      ),
                                      prefixIcon: InkWell(
                                        onTap: () async {
                                          final pickedTime =
                                              await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                          if (pickedTime != null) {
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
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    AppSpaces.height21,
                    // Available Slots
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "End time",
                                style: TextStyle(
                                  fontFamily: CustomFontss.fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpaces.height7,
                              /////////////////////////// END TIME FIELD ///////////
                              TextFormField(
                                validator: (value) =>
                                    InputValidator.validateEndTIme(value),
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
                                  hintStyle: TextStyle(
                                    color: ColorConstant.InputText,
                                  ),
                                  prefixIcon: InkWell(
                                    onTap: () async {
                                      final pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
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
                        AppSpaces.width10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Available slote",
                                style: TextStyle(
                                  fontFamily: CustomFontss.fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpaces.height7,
                              //////////////////// AVAILABEL SLOTE ///////////////////////
                              TextField(
                                controller: availableSloteController,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  fillColor: ColorConstant.textfieldBG,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorConstant.InputBorder,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),

                                  hintText: "Available Slote",

                                  hintStyle: TextStyle(
                                    color: ColorConstant.InputText,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSpaces.height21,

                    //////////////////////////// Entry Fee & Offer Price /////////////////////////
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Entry fee",
                                style: TextStyle(
                                  fontFamily: CustomFontss.fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpaces.height7,
                              TextField(
                                controller: entryFeeController,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorConstant.InputBorder,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Entry Fee",
                                  hintStyle: TextStyle(
                                    color: ColorConstant.InputText,
                                  ),

                                  prefixText: "\$ ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpaces.height21,
                        AppSpaces.width10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Offer price",
                                style: TextStyle(
                                  fontFamily: CustomFontss.fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppSpaces.height7,
                              TextField(
                                controller: offerPriceController,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorConstant.InputBorder,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Offer Price",

                                  hintStyle: TextStyle(
                                    color: ColorConstant.InputText,
                                  ),
                                  prefixText: "\$ ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSpaces.height21,

                    // ---------------- Media Gallery Section ----------------
                    // ---------------- Media Gallery Section ----------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Choose Media",
                          style: TextStyle(
                            fontFamily: CustomFontss.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            context.read<EventBloc>().add(PickImageEvent());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorConstant.GradientColor1,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 14,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons
                                      .photo_library_outlined, // image/gallery icon
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Open Gallery",
                                  style: TextStyle(
                                    fontFamily: CustomFontss.fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstant.MainWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpaces.height16,
                    BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
                        if (state is ImageLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorConstant.GradientColor2,
                              backgroundColor: ColorConstant.MainBlack,
                            ),
                          );
                        }

                        if (state is EventLoaded && state.images.isNotEmpty) {
                          return Row(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.images.length > 5
                                      ? 5
                                      : state.images.length,

                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10,
                                        mainAxisExtent: 100,
                                      ),
                                  itemBuilder: (context, index) {
                                    return MediaSection(
                                      onView: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Container(
                                              width: 300,

                                              height: 400,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                    File(
                                                      state.images[index].path,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      onTap: () {
                                        context.read<EventBloc>().add(
                                          RemoveImageEvent(index: index),
                                        );
                                      },
                                      mediaUrl: state.images[index],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          );
                        }
                        return Center(child: Text(""));
                      },
                    ),

                    AppSpaces.height16,

                    // Cancel & Create Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.CancelClr,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.GradientColor1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  context.read<EventBloc>().add(
                                    AddEventEvent(
                                      eventModel: EventModel(
                                        createdAt: DateTime.now(),
                                        createdBy: FirebaseAuth
                                            .instance
                                            .currentUser!
                                            .uid,
                                        availableSlot:
                                            availableSloteController.text,
                                        entryFee: entryFeeController.text,
                                        offerPrice: offerPriceController.text,
                                        imageUrls: [],

                                        venue: venueController.text,
                                        address: addressController.text,
                                        id: "",
                                        name: nameController.text,
                                        date: dateController.text,
                                        startTime: starttimeController.text,
                                        endTime: endtimeController.text,
                                      ),
                                    ),
                                  );

                                  nameController.clear();
                                  venueController.clear();
                                  dateController.clear();
                                  starttimeController.clear();
                                  entryFeeController.clear();
                                  offerPriceController.clear();
                                  availableSloteController.clear();

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Create",
                                style: TextStyle(
                                  color: ColorConstant.MainWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
