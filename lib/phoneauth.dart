import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taxi_app/verification.dart';


class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "india",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    String phoneAuth = "+${selectedCountry.phoneCode}${phoneController.text.trim()}";

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneAuth,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant verification cases
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Verification failed")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Pin(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Optional: handle auto retrieval timeout
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.asset("images/taxi.jpg"),
            ),
            const Text(
              "PICK & DROP",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
                fontStyle: FontStyle.normal,
              ),
            ),
            const Gap(40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: Text(
                "Welcome! Take a ride to your destination with a fair price.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.all(36.02),
              child: TextFormField(
                cursorColor: Colors.purple,
                controller: phoneController,
                style: const TextStyle(
                  fontSize: 17.04,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your number",
                  hintStyle: const TextStyle(fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.05),
                    borderSide: const BorderSide(color: Colors.redAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.05),
                    borderSide: const BorderSide(color: Colors.redAccent),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: const CountryListThemeData(
                            bottomSheetHeight: 700,
                          ),
                          onSelect: (Country value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          },
                        );
                      },
                      child: Text(
                        "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  suffixIcon: phoneController.text.length > 9
                      ? Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => verifyPhoneNumber(context),
              child: const Text(
                "Confirm",
                style: TextStyle(fontSize: 22.03, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
