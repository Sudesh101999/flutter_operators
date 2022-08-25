import 'package:flutter/material.dart';

class PartOne extends StatefulWidget {
  const PartOne({Key? key}) : super(key: key);

  @override
  State<PartOne> createState() => _PartOneState();
}

class _PartOneState extends State<PartOne> {
  bool _isPersonalVisible = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          profileRow(
            screenWidth,
            "Name",
            "Sudeshwar Thakur",
            Color.fromARGB(100, 190, 221, 244),
          ),
          profileRow(
            screenWidth,
            "Designation",
            "Flutter",
            Color.fromARGB(100, 190, 221, 244),
          ),
          profileRow(
            screenWidth,
            "Employee",
            "Akal",
            Color.fromARGB(100, 190, 221, 244),
          ),
          profileRow(
            screenWidth,
            "Date of Joining",
            "12/12/1220",
            Color.fromARGB(100, 190, 221, 244),
          ),
          profileRow(
            screenWidth,
            "Office",
            "GST Office",
            Color.fromARGB(100, 190, 221, 244),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Profile Information',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          profileRow(
            screenWidth,
            "Aadhar Card",
            "****1234",
            Color.fromARGB(255, 117, 172, 213),
          ),
          profileRow(
            screenWidth,
            "PAN",
            "****1234",
            Color.fromARGB(255, 117, 172, 213),
          ),
          profileRow(
            screenWidth,
            "Father Name",
            "****Name",
            Color.fromARGB(255, 117, 172, 213),
          ),
          profileRow(
            screenWidth,
            "Mother Name",
            "****Name",
            Color.fromARGB(255, 117, 172, 213),
          ),
          profileRow(
            screenWidth,
            "Date of Birth",
            "12/12/2343",
            Color.fromARGB(255, 117, 172, 213),
          ),
          profileRow(
            screenWidth,
            "Date of supe-rannuation",
            "12/12/2343",
            Color.fromARGB(255, 117, 172, 213),
          ),
          qualificationRow(screenWidth, context),
        ],
      ),
    );
  }

  Widget profileRow(
    double screenWidth,
    String title,
    String description,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth / 3,
          margin: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
          color: color,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20.0, top: 8, right: 10, bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Container(
          width: screenWidth / 1.7,
          margin: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          color: color,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20.0, top: 8, right: 10, bottom: 8),
            child: Text(
              description,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget qualificationRow(double screenWidth, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        /*boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0, 3),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],*/
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Qualification at the time of appointment'.toUpperCase()),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isPersonalVisible = !_isPersonalVisible;
                      });
                    },
                    child: Icon(
                      _isPersonalVisible
                          ? Icons.expand_less
                          : Icons.expand_more_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _isPersonalVisible,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: const Offset(0, 3),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            qualificationRowData(
                                screenWidth,
                                "M.Sc. I.T.",
                                "Patkar College of commerce and science",
                                "2022"),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget qualificationRowData(
    double screenWidth,
    String degree,
    String institute,
    String passingYear,
  ) {
    return Container(
      width: screenWidth * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text("Degree : ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.left),
              Text(degree,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black),
                  textAlign: TextAlign.left),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Institute/University : ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
              Container(
                width: screenWidth/2.45,
                child: Text(institute,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black),
                  overflow: TextOverflow.visible,),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Passing Year : ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                passingYear,
                style: TextStyle(
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
