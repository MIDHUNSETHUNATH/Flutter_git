import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:taxi_app/UI/phoneauth.dart';

class Pin extends StatefulWidget {
  final String verificationId;

  const Pin({super.key, required this.verificationId});

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  TextEditingController controller = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> submitPin() async {
    String otp = controller.text.trim();

    if (otp.length == 4) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otp,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

       
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PhoneAuth()),
          
        );
      } catch (e) {
        setState(() {
          errorMessage = "Incorrect OTP. Please try again.";
        });
      }
    } else {
      setState(() {
        errorMessage = "Please enter a 4-digit OTP.";
      });
    }
  }

  void resendOtp() {
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP Resent")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("OTP Verification"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Container(
          margin: const EdgeInsets.only(top: 90),
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text(
                "Your OTP has been sent to the registered phone number.",
                style: TextStyle(fontSize: 12),
              ),
              const Gap(15),
              const Text(
                "We need it for the registration process",
                style: TextStyle(fontSize: 16.08, fontWeight: FontWeight.bold),
              ),
              const Gap(26),
              Pinput(
                controller: controller,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                onCompleted: (pin) => debugPrint(pin),
                onChanged: (value) {
                  if (value.length == 4) {
                    FocusScope.of(context).unfocus();
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const Gap(20),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const Gap(20),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    
                  },
                  child: const Text("Edit your phone number?"),
                ),
              ),
              const Gap(15.05),
              ElevatedButton(
                onPressed:   onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder:(context) =>const MapPage()),
              );
              },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                ),
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(
                    fontSize: 25.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: resendOtp,
                child: const Text("Resend OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


