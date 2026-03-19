import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'student.dart';
import 'bu_personnel.dart';
import 'non_bu_personnel.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF00ADEF),
              const Color.fromARGB(255, 23, 0, 231)
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Categories", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Please select your category.", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20,),

                        FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StudentForm()),
                            );
                          },
                          height: 50,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/student.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Text("Student", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        )),
                        SizedBox(height: 20,),
                        FadeInUp(duration: Duration(milliseconds: 1700), child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BUPersonnelForm()),
                            );
                          },
                          height: 50,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/bupersonel.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Text("BU Personnel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        )),
                        SizedBox(height: 20,),
                        FadeInUp(duration: Duration(milliseconds: 1800), child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NonBUPersonnelForm()),
                            );
                          },
                          height: 50,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/nonbupersonel.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Text("Non BU Personnel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        )),
                        SizedBox(height: 100,),

                      ],
                    ),
                  ), // close Padding inside Container
                ), // close Container
              ), // close outer Padding
            ), // close Expanded
          ],
        ),
      ),
    );
  }
}