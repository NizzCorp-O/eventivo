import 'dart:convert';

import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/core/utils%20/qr_helper.dart';
import 'package:eventivo/core/utils%20/storage_helper.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Data/repositories/tickets_repositories.dart';

import 'package:eventivo/features/Events/Presentation/Bloc/counter/bloc/counter_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/ticket_screen.dart';
import 'package:eventivo/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String eventid;
  final String Url;
  final String title;
  final String date;
  final String starttime;
  final String venue;
  final String price;

  const PaymentScreen({
    super.key,
    required this.title,
    required this.date,
    required this.starttime,
    required this.venue,
    required this.price,
    required this.Url,
    required this.eventid,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? username = FirebaseAuth.instance.currentUser!.displayName;
  TicketsRepositories ticketrepo = TicketsRepositories();

  late Razorpay _razorpay;
  Future<void> _paymentsuccess(PaymentSuccessResponse response) async {
    final attendeesCount = context.read<CounterBloc>().state.count;
    final paymentId = response.paymentId ?? "unknown_payment_id";
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    // QR code data string
    Map<String, dynamic> qrData = {
      "eventId": widget.eventid,
      "paymentId": paymentId,
      "eventName": widget.title,
      "attendees": attendeesCount,
      "userName": username ?? user.email ?? "unknown_user",
    };

    final qrBytes = await generateQrCodeBytes(jsonEncode(qrData));

    final qrUrl = await uploadQrToStorage(widget.eventid, user.uid, qrBytes);

    await ticketrepo.saveTicket(
      widget.eventid,
      user.uid,
      paymentId,
      attendeesCount,
      widget.title,
      qrUrl,
    );
    final event = EventModel(
      id: widget.eventid,
      name: widget.title,
      createdBy: "", // optional
      venue: "",
      address: "",
      date: widget.date ?? "",
      startTime: widget.starttime ?? "",
      endTime: "",
      entryFee: "",
      offerPrice: "",
      availableSlot: "",
      imageUrls: [widget.Url.toString() ?? ""],
      createdAt: DateTime.now(),
    );
    context.read<AuthBlocBloc>().add(AddJoinedEvent(event: event));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TicketScreen(
          eventid:widget.eventid,
          user: userEmail.toString(),
          paymentId: paymentId,
          eventTitle: widget.title,
          attnedees: attendeesCount,
          qurl: qrUrl,
        ),
      ),
    );
  }

  void _paymentfailure(PaymentFailureResponse response) {
    print("Fail $response");
  }

  void _paymentwallet(ExternalWalletResponse response) {
    print("Wallet $response");
  }

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentsuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentfailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _paymentwallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void checkout(num amount, String email, String name) {
    var options = {
      'key': 'rzp_test_RL1mown94Des4t',
      'amount': (amount * 100).toInt(),

      'name': name,
      'description': 'Fine T-Shirt',
      'retry': {'enable': true, 'maxcount': 1},
      'send_sms_hash': true,
      'prefill': {'email': email},
    };
    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CounterBloc>(context).add(ResetCount(initialCount: 1));

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: ColorConstant.MainWhite,
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(
            fontFamily: CustomFontss.fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  border: BoxBorder.all(
                    width: 0,
                    color: ColorConstant.InputBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.Url),
                        ),
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: ColorConstant.GradientColor1,
                              ),
                              SizedBox(width: 8),
                              Text(
                                widget.date,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                radius: 5,

                                backgroundColor: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.starttime,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: ColorConstant.GradientColor1,
                                size: 26,
                              ),
                              SizedBox(width: 8),
                              Text(
                                widget.venue,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: BoxBorder.all(
                    width: 1,
                    color: ColorConstant.InputBorder,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFF9FAFB),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Number of participants ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: ColorConstant.MainWhite,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 21,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_2_outlined,
                                color: ColorConstant.GradientColor1,
                              ),
                              SizedBox(width: 5),
                              Text("Attendees"),
                            ],
                          ),
                          BlocBuilder<CounterBloc, CounterState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<CounterBloc>().add(
                                        DegrimentEvents(),
                                      );
                                    },
                                    child: Container(
                                      width: 40, // diameter = radius * 2
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: BoxBorder.all(
                                          width: 1,
                                          color: ColorConstant.InputBorder,
                                        ),
                                        color: ColorConstant.MainWhite,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    state.count.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 15),
                                  InkWell(
                                    onTap: () {
                                      context.read<CounterBloc>().add(
                                        IncrementEvents(),
                                      );
                                    },
                                    child: Container(
                                      width: 40, // diameter = radius * 2
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: ColorConstant
                                            .GradientColor1, // same background color
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  final int numericPrice =
                      int.tryParse(widget.price.toString()) ?? 0;
                  final total = numericPrice * state.count;
                  final double gst = total * 0.18;
                  final double totalamount = total + gst;
                  print("tottal = ${total}");
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.MainWhite,
                      boxShadow: [],
                      border: Border.all(
                        width: 1,
                        color: ColorConstant.InputBorder,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 19),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Breakdown",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: CustomFontss.fontFamily,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ticket Price (₹${widget.price} x ${state.count})",

                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: CustomFontss.fontFamily,
                              ),
                            ),
                            Text("$total", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("GST (18%)", style: TextStyle(fontSize: 16)),
                            Text(
                              gst.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          color: ColorConstant.InputBorder,
                          radius: BorderRadius.circular(1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total amount",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\₹$totalamount",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),

            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstant.MainWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: ColorConstant.InputBorder,
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Powered by"),
                            SizedBox(width: 10),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    120, // ← limit width so text doesn’t overflow
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorConstant.PrimaryBlue,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                "Razorpay",
                                overflow:
                                    TextOverflow.ellipsis, // ← truncate text
                                softWrap: false,
                                style: TextStyle(
                                  color: ColorConstant.MainWhite,
                                  fontFamily: CustomFontss.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card_rounded,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Credit/Debit Card",
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_android_rounded,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text("UPI", style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mobile_screen_share,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text("Net Banking", style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.wallet,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text("Wallet", style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    final int numericPrice =
                        int.tryParse(widget.price.toString()) ?? 0;
                    final total = numericPrice * state.count;
                    final double gst = total * 0.18;
                    final double totalamount = total + gst;

                    return InkWell(
                      onTap: () {
                        checkout(totalamount, userEmail ?? "", "shafeeque");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset: Offset(1, 1),
                              color: Colors.grey,
                            ),
                          ],
                          color: ColorConstant.GradientColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock, color: ColorConstant.MainWhite),
                              SizedBox(width: 5),
                              Text(
                                "Pay ₹${totalamount} ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: CustomFontss.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.MainWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 15,
                  Icons.diamond_outlined,
                  color: ColorConstant.GradientColor1,
                ),
                SizedBox(width: 5),
                Text(
                  "Secure Payment powered by Razorpay",
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
