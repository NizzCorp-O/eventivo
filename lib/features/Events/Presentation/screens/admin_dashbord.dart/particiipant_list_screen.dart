// import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
// import 'package:eventivo/core/utils%20/fonts.dart';
// import 'package:eventivo/features/Events/Presentation/widgets/event_widgets/filtered_events.dart';
// import 'package:flutter/material.dart';

// class ScannTicketsScreen extends StatefulWidget {
//   const ScannTicketsScreen({super.key});

//   @override
//   State<ScannTicketsScreen> createState() => _ScannTicketsScreenState();
// }

// class _ScannTicketsScreenState extends State<ScannTicketsScreen> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstant.MainWhite,
//       appBar: AppBar(
//         backgroundColor: ColorConstant.MainWhite,
//         title: Center(
//           child: Text(
//             "Participants",
//             style: TextStyle(
//               fontFamily: CustomFontss.fontFamily,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.person, color: ColorConstant.InputText),
//                 fillColor: ColorConstant.textfieldBG,
//                 filled: true,
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 hintText: "Search participants..",
//                 hintStyle: TextStyle(color: ColorConstant.InputText),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorConstant.InputBorder),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//             ),

//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Flexible(
//                   child: participan_container(
//                     title: "All",
//                     selectedindex: selectedIndex == 0,
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 0;
//                         print(selectedIndex);
//                       });
//                     },
//                   ),
//                 ),
//                 Flexible(
//                   child: participan_container(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 1;
//                         print(selectedIndex);
//                       });
//                     },
//                     selectedindex: selectedIndex == 1,
//                     title: "Confirmed (18)",
//                   ),
//                 ),
//                 Flexible(
//                   child: participan_container(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = 2;
//                         print(selectedIndex);
//                       });
//                     },
//                     selectedindex: selectedIndex == 2,
//                     title: "Cancelled (10)",
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.all(8),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 border: BoxBorder.all(
//                   width: 1,
//                   color: ColorConstant.InputBorder,
//                 ),
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Circular Image
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://images.pexels.com/photos/1065084/pexels-photo-1065084.jpeg",
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 12),

//                   // Title + Description + Confirmed
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Title
//                         Text(
//                           "Sarah Chen", // title
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontFamily: CustomFontss.fontFamily,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),

//                         const SizedBox(height: 4),

//                         // Description
//                         Text(
//                           "sarah.chen@gmail.com", // description
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                         ),

//                         const SizedBox(height: 6),

//                         // Confirmed status
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 5,
//                               backgroundColor: Colors.green,
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               "Confirmed", // status
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class participan_container extends StatelessWidget {
//   final void Function()? onTap;
//   final bool selectedindex;

//   final String title;
//   const participan_container({
//     super.key,
//     required this.title,
//     this.onTap,
//     required this.selectedindex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           height: 60,
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           decoration: BoxDecoration(
//             color: selectedindex
//                 ? ColorConstant.GradientColor1
//                 : Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Center(
//             child: Text(
//               textAlign: TextAlign.center,
//               title,

//               style: TextStyle(
//                 fontSize: 15,
//                 color: selectedindex ? ColorConstant.MainWhite : Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
