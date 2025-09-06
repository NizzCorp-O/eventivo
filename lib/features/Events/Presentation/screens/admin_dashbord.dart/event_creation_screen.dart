import 'dart:io';

import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/repositories/Event_repositories.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EventCreationScreen extends StatelessWidget {
  const EventCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventRepository eventrepo = EventRepository();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        centerTitle: true,
        title: const Text(
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Event Details",
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 7),

                  // Event Name
                  TextField(
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
                  const SizedBox(height: 21),

                  // Venue
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade400,
                      ),
                      fillColor: ColorConstant.textfieldBG,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Venue",
                      hintStyle: TextStyle(color: ColorConstant.InputText),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 21),

                  // Date & Time Row
                  BlocBuilder<EventBloc, EventState>(
                    builder: (context, state) {
                      if (state is EventFormState) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          dateController.text = state.dateString ?? "";
                          timeController.text = state.timeString ?? "";
                        });
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<EventBloc, EventState>(
                              builder: (context, state) {
                                return TextField(
                                  controller: dateController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    fillColor: ColorConstant.textfieldBG,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstant.InputBorder,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),

                                    hintText: "Date",
                                    hintStyle: TextStyle(
                                      color: ColorConstant.InputText,
                                    ),
                                    prefixIcon: InkWell(
                                      onTap: () async {
                                        final pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        );
                                        if (pickedDate != null) {
                                          dateController.text = DateFormat(
                                            "dd MMM yyyy",
                                          ).format(pickedDate); // intl package
                                          context.read<EventBloc>().add(
                                            PickDate(pickedDate),
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: ColorConstant.GradientColor2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 21),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: timeController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorConstant.InputBorder,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                fillColor: ColorConstant.textfieldBG,
                                filled: true,

                                hintText: "Time",
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
                                        PickTime(pickedTime),
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
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 21),

                  // Entry Fee & Offer Price
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
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
                      ),
                      SizedBox(height: 21),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
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
                      ),
                    ],
                  ),
                  SizedBox(height: 21),

                  // Available Slots
                  TextField(
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

                      hintStyle: TextStyle(color: ColorConstant.InputText),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 21),

                  // Cancellation Time
                  // Row(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         border: Border.all(color: ColorConstant.InputBorder),
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: IconButton(
                  //         onPressed: () {},
                  //         icon: const Icon(Icons.remove),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Container(
                  //       width: 100,
                  //       decoration: BoxDecoration(
                  //         color: ColorConstant.textfieldBG,
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       height: 40,
                  //       child: const Center(
                  //         child: Text("0", style: TextStyle(fontSize: 18)),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.grey.shade400),
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: IconButton(
                  //         onPressed: () {},
                  //         icon: const Icon(Icons.add),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     const Text("Hrs"),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),

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
                            color: ColorConstant.PrimaryBlue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
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
                                "Open gallery",
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
                  SizedBox(height: 21),

                  BlocListener<EventBloc, EventState>(
                    listener: (context, state) {},
                    child: BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
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
                              const SizedBox(width: 12),
                            ],
                          );
                        }

                        return Container(
                          child: Icon(
                            Icons.image_rounded,
                            size: 40,
                            color: ColorConstant.GradientColor1,
                          ),
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(18),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Cancel & Create Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFECACA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.GradientColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Create",
                            style: TextStyle(color: ColorConstant.MainWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaSection extends StatelessWidget {
  final XFile mediaUrl;
  final void Function()? onTap;
  const MediaSection({super.key, required this.mediaUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: FileImage(File(mediaUrl.path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
