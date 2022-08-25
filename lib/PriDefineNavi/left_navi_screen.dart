import 'package:flutter/material.dart';

import 'pages/part_1.dart';
import 'pages/part_2.dart';
import 'pages/part_3.dart';

class NaviPage extends StatefulWidget {
  const NaviPage({Key? key}) : super(key: key);

  @override
  State<NaviPage> createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage> {
  var currentPage = DrawerSections.profile;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.profile) {
      container = PartOne();
    } else if (currentPage == DrawerSections.history_of_service) {
      container = PartTwo();
    } else if (currentPage == DrawerSections.certificate_attestation) {
      container = PartThree();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[350],
        title: Text("Rapid Tech"),
      ),
      body: container,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20,),
                UserAccountsDrawerHeader(
                  accountName: Text(''),
                  accountEmail: Text(''),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/ehrms_logo.gif',
                      ),
                    ),
                  ),
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Profile", Icons.person_outline_outlined,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(2, "History of Service", Icons.history_outlined,
              currentPage == DrawerSections.history_of_service ? true : false),
          menuItem(
              3,
              "Certificate Attestation",
              Icons.history_outlined,
              currentPage == DrawerSections.certificate_attestation
                  ? true
                  : false),
          Divider(),
          // menuItem(4, "...", Icons.event, currentPage == DrawerSections.events ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.only(left: 15,top: 5,bottom: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.zero
            // Radius.circular(15.0), //                 <--- border radius here
            ),
        color: selected ? Colors.blue[400] : Colors.grey[100],
      ),
      // color: selected ? Colors.blue[400] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.profile;
            } else if (id == 2) {
              currentPage = DrawerSections.history_of_service;
            } else if (id == 3) {
              currentPage = DrawerSections.certificate_attestation;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: id == 3
                    ? ImageIcon(
                        AssetImage('assets/images/history_of_service.png'),
                        size: 30,
                        // color: Colors.black,
                        color: selected ? Colors.white : Colors.black,
                      )
                    : Icon(
                        icon,
                        size: 25,
                        // color: Colors.black,
                        color: selected ? Colors.white : Colors.black,
                      ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  profile,
  history_of_service,
  certificate_attestation,
}
