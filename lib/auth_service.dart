import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithPhoneNumber(String phoneNumber, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
     
        if (kDebugMode) {
          print(e.message);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
       
        String smsCode = 'xxxx'; 

       
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    
        _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
       
      },
    );
  }
}



