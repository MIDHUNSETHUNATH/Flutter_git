import 'package:flutter/material.dart';
import 'package:taxi_app/UI/phoneauth.dart';


class OpenScreen extends StatefulWidget {
  const OpenScreen({super.key});

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // To center the content vertically
              children: [
                Image.asset(
                  "images/car2.jpg",
                  height: 350,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Hello TaXi",
                  style: TextStyle(
                    fontSize: 50,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 5),
              onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder:(context) =>const PhoneAuth() ,),
              );
              },
              
               child:const Text("Let's star your journey",
                   
              style: TextStyle(color: Colors.black,fontSize: 17.05),
              ),

              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
