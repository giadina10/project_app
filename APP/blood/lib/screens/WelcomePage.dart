
import 'package:flutter/material.dart';
import 'package:blood/screens/items.dart';
import 'package:blood/screens/login3.dart';



class WelcomeScreen extends StatefulWidget { 
 @override   _WelcomeScreenState createState() => _WelcomeScreenState(); 
 }
class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Widget> slides = items
      .map((item) => Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: 220.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text(item['header'],
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(241, 245, 139, 112),
                              height: 2.0)),
                      Text(
                        item['description'],
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.2,
                            fontSize: 16.0,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          )))
      .toList();

  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Color(0XFF256075)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final _pageViewController = new PageController();
  
  @override
  void initState() {
    super.initState();
    _pageViewController.addListener(() {
      setState(() {
        currentPage = _pageViewController.page!; //null check
      });
    });
  }
  
 @override
 Widget build(BuildContext context) {
  return Scaffold(
      body: Container(
      
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                return slides[index];
              },
            ), 
            
            if (currentPage == slides.length - 1) // Mostra il bottone solo quando si è sull'ultima pagina
              Positioned(
                bottom: 80.0,
                left: 40,
                right: 40,
               
                child: Center(
                  
             
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login3');
                    },
                    color: const Color.fromARGB(255, 241, 96, 85),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    
                   
                    child: Center(
                      child: Text("Getting started", style: TextStyle(color: Colors.white, fontSize: 25),),
                    ),
                  ),
                    
                ),
              ),
              //FINO A QUI

            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                )
                //  ),
                )
            // )
          ],
        ),
      ),
    );
  }
}