// ignore_for_file: file_names
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/Screens/Model/groundBookingModel.dart';
import 'package:user_app/Screens/grounds.dart';
import 'package:jazzcash_flutter/jazzcash_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Book_A_Ground extends StatefulWidget {
  final String documentId;
  const Book_A_Ground({Key? key, required this.documentId}) : super(key: key);

  @override
  State<Book_A_Ground> createState() => _Book_A_GroundState();
}

payment() async {
  var digest;
  String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
  String dexpiredate = DateFormat("yyyyMMddHHmmss")
      .format(DateTime.now().add(Duration(days: 1)));
  String tre = "T" + dateandtime;
  String pp_Amount = "100000";
  String pp_BillReference = "billRef";
  String pp_Description = "Description";
  String pp_Language = "EN";
  String pp_MerchantID = "Merc0003";
  String pp_Password = "0123456789";

  String pp_ReturnURL =
      "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
  String pp_ver = "1.1";
  String pp_TxnCurrency = "PKR";
  String pp_TxnDateTime = dateandtime.toString();
  String pp_TxnExpiryDateTime = dexpiredate.toString();
  String pp_TxnRefNo = tre.toString();
  String pp_TxnType = "MWALLET";
  String ppmpf_1 = "4456733833993";
  String IntegeritySalt = "your key";
  String and = '&';
  String superdata = IntegeritySalt +
      and +
      pp_Amount +
      and +
      pp_BillReference +
      and +
      pp_Description +
      and +
      pp_Language +
      and +
      pp_MerchantID +
      and +
      pp_Password +
      and +
      pp_ReturnURL +
      and +
      pp_TxnCurrency +
      and +
      pp_TxnDateTime +
      and +
      pp_TxnExpiryDateTime +
      and +
      pp_TxnRefNo +
      and +
      pp_TxnType +
      and +
      pp_ver +
      and +
      ppmpf_1;

  var key = utf8.encode(IntegeritySalt);
  var bytes = utf8.encode(superdata);
  var hmacSha256 = new Hmac(sha256, key);
  Digest sha256Result = hmacSha256.convert(bytes);
  var url = Uri.parse(
      'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction');

  var response = await http.post(url, body: {
    "pp_Version": pp_ver,
    "pp_TxnType": pp_TxnType,
    "pp_Language": pp_Language,
    "pp_MerchantID": pp_MerchantID,
    "pp_Password": pp_Password,
    "pp_TxnRefNo": tre,
    "pp_Amount": pp_Amount,
    "pp_TxnCurrency": pp_TxnCurrency,
    "pp_TxnDateTime": dateandtime,
    "pp_BillReference": pp_BillReference,
    "pp_Description": pp_Description,
    "pp_TxnExpiryDateTime": dexpiredate,
    "pp_ReturnURL": pp_ReturnURL,
    "pp_SecureHash": sha256Result.toString(),
    "ppmpf_1": "4456733833993"
  });

  print("response=>");
  print(response.body);
}

class _Book_A_GroundState extends State<Book_A_Ground> {
  TextEditingController _dateController = TextEditingController();
  String _setDate = '';
  DateTime selectedDate = DateTime.now();
  String paymentStatus = "pending";
  ProductModel productModel = ProductModel("Product 1", "100");
  String integritySalt = "21whx5by3t";
  String merchantID = "MC55145";
  String merchantPassword = "2vz1b384v2";
  String transactionUrl =
      "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";

  final _auth = FirebaseAuth.instance;

  String? dropdownValue = 'Morning 8am - 2pm';
  //  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController bookingDayEditingController = TextEditingController();
  TextEditingController bookingSlotEditingController = TextEditingController();

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser!;
    GroundBookingModel groundBookingModel = GroundBookingModel();

    // writing all the values//post
    groundBookingModel.uid = FirebaseAuth.instance.currentUser!.uid;
    groundBookingModel.bookingDay = _dateController.text;
    groundBookingModel.groundPrice = groundDocs['price'];
    groundBookingModel.userName = userDocs['fullName'];
    groundBookingModel.userContact = userDocs['phoneNumber'];
    groundBookingModel.status = 'Pending';
    groundBookingModel.groundUid = widget.documentId;
    groundBookingModel.groundName = groundDocs['groundName'];
    groundBookingModel.groundContact = groundDocs['phoneNumber'];
    groundBookingModel.date =
        '${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}/${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    groundBookingModel.userEmail = userDocs['email'];
    groundBookingModel.groundEmail = groundDocs['email'];
    groundBookingModel.bookingSlot = dropdownValue;
    groundBookingModel.groundLocation = groundDocs['location'];

    await firebaseFirestore
        .collection('groundBookings')
        .doc()
        .set(groundBookingModel.toMap());
    Fluttertoast.showToast(msg: "Your request has been sent");

    // Navigator.pushAndRemoveUntil(
    //     (this.context),
    //     MaterialPageRoute(builder: (context) => Grounds()),
    //     (route) => false);
    payment();
  }

  late DateTime _selectedDay;
  late CollectionReference _userEventsCollection;
  var groundDocs;
  var userDocs;
  @override
  void initState() {
    super.initState();
    readUser().then((value) => {
          setState(() {
            userDocs = value;
          })
        });
    readWorker().then((value) => {
          setState(() {
            groundDocs = value;
          })
        });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });

    _storeEventData(selectedDay);
  }

  void _storeEventData(DateTime selectedDay) {
    final eventData = {
      'date': selectedDay,
      // Add more data fields as per your requirement
    };

    _userEventsCollection.add(eventData).then((value) {
      print('Event data stored in Firestore: $eventData');
    }).catchError((error) {
      print('Error storing event data: $error');
    });
  }

  Widget build(BuildContext context) {
    final bookingDay = TextFormField(
        autofocus: false,
        controller: bookingDayEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          bookingDayEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.calendar_today),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Booking Date",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20,
        ),
        title: Text("Booking Details"),
        backgroundColor: Color.fromARGB(214, 102, 50, 98),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height - 120,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: TextFormField(
                    autofocus: false,
                    controller: _dateController,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _setDate = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 64, 156, 33),
                      )),
                      prefixIcon: Icon(Icons.calendar_month),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Select Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ))
                // Container(
                //   width: _width / 1.7,
                //   height: _height / 9,
                //   margin: EdgeInsets.only(top: 30),
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(color: Colors.grey[200]),
                //   child: TextFormField(
                //     style: TextStyle(fontSize: 40),
                //     textAlign: TextAlign.center,
                //     enabled: false,
                //     keyboardType: TextInputType.text,
                //     controller: _dateController,
                //     onSaved: (String? val) {
                //       _setDate = val!;
                //     },
                //     decoration: InputDecoration(
                //         disabledBorder:
                //             UnderlineInputBorder(borderSide: BorderSide.none),
                //         contentPadding: EdgeInsets.only(top: 0.0)),
                //   ),
                // ),
                ),
            const SizedBox(height: 20),
            // Categories DropDownValue
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Color.fromARGB(214, 102, 50, 98)),
                      right:
                          BorderSide(color: Color.fromARGB(214, 102, 50, 98)),
                      top: BorderSide(color: Color.fromARGB(214, 102, 50, 98)),
                      bottom:
                          BorderSide(color: Color.fromARGB(214, 102, 50, 98)))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  // isDense reduce the button height
                  isDense: true,
                  icon: const Icon(Icons.arrow_downward,
                      color: Color.fromARGB(214, 102, 50, 98)),
                  elevation: 16,
                  alignment: AlignmentDirectional.center,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  dropdownColor: Colors.white,
                  items: <String>[
                    'Morning 8am - 2pm',
                    'Evening 4pm - 10pm',
                    'Night 12am - 6am',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            // const SizedBox(height: 20),
            // TableCalendar(
            //   calendarFormat: _calendarFormat,
            //   firstDay: DateTime.now(),
            //   lastDay: DateTime(DateTime.now().year+1),
            //   focusedDay: DateTime.now(),
            //   onDaySelected: _onDaySelected,
            // ),
            //     const SizedBox(height: 20),
            //     Container(
            // child: SfDateRangePicker(
            //   onSelectionChanged: _onSelectionChanged,
            //   selectionMode: DateRangePickerSelectionMode.range,
            // ),),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    var result = await FirebaseFirestore.instance
                        .collection('groundBookings')
                        .where('booking day', isEqualTo: _dateController.text)
                        .where('booking slot',
                            isEqualTo: dropdownValue.toString())
                        .get();

                    if (result.docs.isNotEmpty) {
                      Fluttertoast.showToast(
                          msg:
                              'Ground is already booked kindly pick another slot or day');
                    } else {
                      if (_dateController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please Enter Booking Date");
                      } else {
                        postDetailsToFirestore();
                        // payment();
                        _payViaJazzCash(productModel, context);
                      }
                    }
                  },
                  minWidth: double.infinity,
                  color: Color.fromARGB(214, 102, 50, 98),
                  height: 50,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Book",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future readUser() async {
    var querySnapshot;
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (querySnapshot.isNotEmpty) {
        return querySnapshot;
      }
    } catch (e) {
      print(e);
    }
    return querySnapshot;
  }

  Future readWorker() async {
    var querySnapshot;
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection('Grounds')
          .doc(widget.documentId)
          .get();
      if (querySnapshot.isNotEmpty) {
        return querySnapshot;
      }
    } catch (e) {
      print(e);
    }
    return querySnapshot;
  }

  Future _payViaJazzCash(ProductModel element, BuildContext c) async {
    // print("clicked on Product ${element.name}");

    try {
      JazzCashFlutter jazzCashFlutter = JazzCashFlutter(
        merchantId: merchantID,
        merchantPassword: merchantPassword,
        integritySalt: integritySalt,
        isSandbox: true,
      );

      DateTime date = DateTime.now();

      JazzCashPaymentDataModelV1 paymentDataModelV1 =
          JazzCashPaymentDataModelV1(
        ppAmount: '${element.productPrice}',
        ppBillReference:
            'refbill${date.year}${date.month}${date.day}${date.hour}${date.millisecond}',
        ppDescription:
            'Product details  ${element.productName} - ${element.productPrice}',
        ppMerchantID: merchantID,
        ppPassword: merchantPassword,
        ppReturnURL: transactionUrl,
      );

      jazzCashFlutter
          .startPayment(
              paymentDataModelV1: paymentDataModelV1, context: context)
          .then((_response) {
        print("response from jazzcash $_response");

        // _checkIfPaymentSuccessfull(_response, element, context).then((res) {
        //   // res is the response you returned from your return url;
        //   return res;
        // });

        setState(() {});
      });
    } catch (err) {
      print("Error in payment $err");
      // CommonFunctions.CommonToast(
      //   message: "Error in payment $err",
      // );
      return false;
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }
}

class ProductModel {
  String? productName;
  String? productPrice;

  ProductModel(this.productName, this.productPrice);
}
