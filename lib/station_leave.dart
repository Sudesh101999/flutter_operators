import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';

class StationLeave extends StatefulWidget {
  static const routeName = '/..';

  const StationLeave({Key? key}) : super(key: key);

  @override
  State<StationLeave> createState() => _StationLeaveState();
}

enum BestTutorSite { Domestic_visit, International_visit }

class _StationLeaveState extends State<StationLeave> {
  BestTutorSite _site = BestTutorSite.Domestic_visit;
  bool _placeErrorVisiblity = false;
  bool _stateWidgitVisiblity = true;
  bool _stateErrorVisiblity = false;

  bool _districtWidgitVisiblity = true;
  bool _districtErrorVisiblity = false;

  bool _countryWidgitVisiblity = false;
  bool _countryErrorVisiblity = false;

  bool _dateFromErrorVisiblity = false;
  bool _dateToErrorVisiblity = false;

  Color textFieldBgColor = Color(0xffB4B4B4).withOpacity(0.4);

  var placeBorderWidth = 1.0;
  Color placeBorderColor = Colors.grey; //Color(0xffB4B4B4).withOpacity(0.4);
  var stateBorderWidth = 1.0;
  Color stateBorderColor = Colors.grey; //Color(0xffB4B4B4).withOpacity(0.4);
  var districtBorderWidth = 1.0;
  Color districtBorderColor = Colors.grey; //Color(0xffB4B4B4).withOpacity(0.4);
  var dateFromBorderWidth = 1.0;
  Color dateFromBorderColor = Colors.grey; //Color(0xffB4B4B4).withOpacity(0.4);
  var dateToBorderWidth = 1.0;
  Color dateToBorderColor = Colors.grey; //Color(0xffB4B4B4).withOpacity(0.4);

  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();

  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  late DateTime _selectedFromDate = DateTime.now();
  late DateTime _selectedToDate = DateTime.now();

  ///////////////////////////////////////////................................................
  DateTimeRange? _selectedDateRange;

  // This function will be triggered when the floating button is pressed
  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 1, 1),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      setState(() {
        _selectedDateRange = result;
        DateTime tempStartDate = DateTime.parse(
            "${_selectedDateRange?.start.toString().split(' ')[0]}");
        DateTime tempEndDate = DateTime.parse(
            "${_selectedDateRange?.end.toString().split(' ')[0]}");
        print(
            'formatedDateTime: ${DateFormat('dd-MM-yyyy').format(tempStartDate)}');

        _dateFromController.text =
            DateFormat('dd-MM-yyyy').format(tempStartDate);
        _dateToController.text = DateFormat('dd-MM-yyyy').format(tempEndDate);
      });
    }
  }

  ///////////////////////////////////////////................................................

  //Method for showing the date picker
  void _pickDateToDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().month + _selectedFromDate.month),
      firstDate: DateTime(DateTime.now().month + _selectedFromDate.month),
      // firstDate: DateTime(DateTime.now().year ,DateTime.now().month, DateTime.now().day + _selectedFromDate.day),
      lastDate: DateTime(DateTime.now().year + 5),
    ).then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedToDate = pickedDate;
        _dateToController.text =
            DateFormat('dd-MM-yyyy').format(_selectedToDate);
      });
    });
  }

  @override
  void dispose() {
    _placeController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sreenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/..');
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: const Text('Station Leaves'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Permission of leave station(Saturday, Sunday and Gazetted Holidya only)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: sreenWidth / 1.1,
              height: screenHeight / 8.1,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.9,
                    color: Colors.blueAccent,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(-10, 0),
                      child: ListTile(
                        title: Transform.translate(
                            offset: Offset(-15, 0),
                            child: const Text('Domestic Visit')),
                        leading: Radio(
                          value: BestTutorSite.Domestic_visit,
                          groupValue: _site,
                          onChanged: (BestTutorSite? value) {
                            setState(() {
                              _site = value!;
                              _stateWidgitVisiblity = true;
                              _districtWidgitVisiblity = true;

                              _countryWidgitVisiblity = false;
                            });
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-10, -20),
                      child: ListTile(
                        title: Transform.translate(
                            offset: Offset(-15, 0),
                            child: const Text('International Visit')),
                        leading: Radio(
                          value: BestTutorSite.International_visit,
                          groupValue: _site,
                          onChanged: (BestTutorSite? value) {
                            setState(() {
                              _site = value!;
                              _stateWidgitVisiblity = false;
                              _districtWidgitVisiblity = false;

                              _countryWidgitVisiblity = true;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //....input fields
            Container(
              width: sreenWidth / 1.1,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.9,
                    color: Colors.blueAccent,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Place
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Place To be Visited:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          // color: textFieldBgColor,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: placeBorderWidth,
                            color: placeBorderColor,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, left: 10),
                          child: Center(
                            child: TextFormField(
                              controller: _placeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _placeErrorVisiblity = true;
                                  });
                                } else {
                                  setState(() {
                                    _placeErrorVisiblity = false;
                                  });
                                }
                              },
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.home),//left side
                                suffixIcon: Icon(Icons.home), // right side
                                border: InputBorder.none,
                                hintText: 'Place',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _placeErrorVisiblity,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 14, top: 5),
                            child: Text(
                              "Enter visiting place",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //State
                  Visibility(
                    visible: _stateWidgitVisiblity,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              'State:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(right: 5),
                          /*decoration: BoxDecoration(
                            color: textFieldBgColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 0.0,
                              color: textFieldBgColor,
                            ),
                          ),*/
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Center(
                              child: DropdownSearch<String>(
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                mode: Mode.BOTTOM_SHEET,
                                //to show search box
                                showSearchBox: true,
                                showSelectedItem: true,
                                //list of dropdown items
                                items: state,
                                // label: "Country",
                                showAsSuffixIcons: true,
                                onChanged: print,
                                selectedItem: "Select State",
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _stateErrorVisiblity,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 14, top: 5),
                              child: Text(
                                "Enter visiting State",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),

                  /////////////////////////////////////.....District
                  Visibility(
                    visible: _districtWidgitVisiblity,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              'District:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(right: 5),
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Center(
                              child: DropdownSearch<String>(
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                mode: Mode.BOTTOM_SHEET,
                                //to show search box
                                showSearchBox: true,
                                showSelectedItem: true,
                                //list of dropdown items
                                items: state,
                                // label: "Country",
                                showAsSuffixIcons: true,
                                onChanged: print,
                                selectedItem: "Select State",
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _districtErrorVisiblity,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 14, top: 5),
                              child: Text(
                                "Enter visiting District",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),

                  /////////////////////////////////..........country [depends]

                  Visibility(
                    visible: _countryWidgitVisiblity,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              'Country:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(right: 5),
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Center(
                              child: DropdownSearch<String>(
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                mode: Mode.BOTTOM_SHEET,
                                showSearchBox: true,
                                showSelectedItem: true,
                                items: state,
                                // label: "Country",
                                showAsSuffixIcons: true,
                                onChanged: print,
                                selectedItem: "Select Country",
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _countryErrorVisiblity,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 14, top: 5),
                              child: Text(
                                "Enter visiting Country",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),

                  ///////////////////////////.......date from
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Date From:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          // color: textFieldBgColor,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: dateFromBorderWidth,
                            color: dateFromBorderColor,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, left: 10),
                          child: Center(
                            child: TextFormField(
                              controller: _dateFromController,
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _dateFromErrorVisiblity = true;
                                  });
                                } else {
                                  setState(() {
                                    _dateFromErrorVisiblity = false;
                                  });
                                }
                              },
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.home),//left side
                                suffixIcon: Icon(Icons.date_range_rounded),
                                // right side
                                border: InputBorder.none,
                                hintText: 'Date from',
                              ),
                              // onTap: _pickDateFromDialog,
                              onTap: _show,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _dateFromErrorVisiblity,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 14, top: 5),
                            child: Text(
                              "Enter visiting place",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //////////////////////////////..........date to
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Date To:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          // color: textFieldBgColor,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: dateToBorderWidth,
                            color: dateToBorderColor,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, left: 10),
                          child: Center(
                            child: TextFormField(
                              controller: _dateToController,
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _dateToErrorVisiblity = true;
                                  });
                                } else {
                                  setState(() {
                                    _dateToErrorVisiblity = false;
                                  });
                                }
                              },
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.home),//left side
                                suffixIcon: Icon(Icons.date_range_rounded),
                                // right side
                                border: InputBorder.none,
                                hintText: 'Place',
                              ),
                              // onTap: _pickDateToDialog,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _dateToErrorVisiblity,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 14, top: 5),
                            child: Text(
                              "Enter visiting place",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: const Text('StationLeave'),
                      onPressed: () {
                        // Navigate to second route when tapped.
                        setState(() {
                          if (_placeController.text.isEmpty) {
                            displayMessage('कृपया सेवार्थ आयडी एंटर करा');
                            placeBorderColor = Colors.red; // change the color
                            placeBorderWidth = 2.0;
                            _placeErrorVisiblity = true;
                            return;
                          } else {
                            displayMessage('data inserted');
                            placeBorderColor = const Color(0xffB4B4B4)
                                .withOpacity(0.4); // change the color
                            placeBorderWidth = 1;
                            _placeErrorVisiblity = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              width: sreenWidth / 1.1,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.9,
                  color: Colors.blueAccent,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  listStationLeavesHistory(
                      1,
                      1,
                      "10-10-2022",
                      "10-12-2022",
                      "Mumbai",
                      "india",
                      "Mumbai",
                      "Maharastra",
                      "Type",
                      "status",
                      "Cancel"),
                  listStationLeavesHistory(
                      1,
                      1,
                      "10-10-2022",
                      "10-12-2022",
                      "Mumbai",
                      "india",
                      "Mumbai",
                      "Maharastra",
                      "Type",
                      "status",
                      "Cancel"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> state = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];
}

Widget listStationLeavesHistory(
    int srNo,
    int stationLeaveFormId,
    String dateFrom,
    String toDate,
    String placeToVisit,
    String country,
    String state,
    String district,
    String visitType,
    String stationLeaveStatus,
    String action) {

  return Container(
    margin: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
    padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      border: Border.all(color: Colors.grey.shade300, width: 2),
      borderRadius: const BorderRadius.all(
          Radius.circular(15.0) //                 <--- border radius here
          ),
    ),
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Visited Place: $placeToVisit",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              country != "" ? Text("Country: $country",style: TextStyle(fontSize: 16),) : const SizedBox(),
              state != "" ? Text("state: $state",style: TextStyle(fontSize: 16)) : const SizedBox(),
              district != "" ? Text("district: $district",style: TextStyle(fontSize: 16)) : const SizedBox(),
              visitType != "" ? Text("visitType: $visitType",style: TextStyle(fontSize: 16)) : const SizedBox(),
              stationLeaveStatus != "" ? Text("Status: $stationLeaveStatus",style: TextStyle(fontSize: 16)) : const SizedBox(),

              SizedBox(height: 5,),
              Text(dateFrom +" To "+ toDate,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)

            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.download,size: 30,),
              SizedBox(
                height: 40,
              ),
              Icon(Icons.delete_forever,size: 30,color: Colors.red,)
            ],
          ),
        ],
      ),
    ),
  );
}
