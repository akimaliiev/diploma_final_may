// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diploma_16_10/components/my_button.dart';
import 'package:diploma_16_10/components/my_textfield.dart';
import 'package:diploma_16_10/components/square_tile.dart';
import 'package:diploma_16_10/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async{
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(),
      ),
    );
    if (passwordController.text != confirmPasswordController.text){
      Navigator.pop(context);
      showErrorMessage("Passwords don't match");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );
      FirebaseFirestore.instance
      .collection("Users")
      .doc(userCredential.user!.email)
      .set({
        'username': emailController.text.split('@')[0],
        'bio':'Empty bio..'
      });

      if(context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      showErrorMessage(e.code);
    }

  }




  void showErrorMessage(String message){
    showDialog(
      context: context, 
      builder: (context){
        return const AlertDialog(
          backgroundColor: Colors.grey,
          title: Center(
            child: Text(
              "Something went wrong!",
              style: TextStyle(color: Colors.white),
            )
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25,),
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
          
                const SizedBox(height: 25,),
          
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16
                    ),
                ),
          
                const SizedBox(height: 25,),
          
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
          
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 25,),
          
                MyButton(
                  onTap: signUserUp,
                  text: 'Sign Up',
                ),
          
                const SizedBox(height: 50,),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: .7,
                          color: Colors.grey[600],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                          ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: .7,
                          color: Colors.grey[600],
                          ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 20,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: ()=> AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google_logo.png'
                      ),
                    SizedBox(width: 10,),
          
                    SquareTile(
                      onTap: (){},
                      imagePath: 'lib/images/android_logo.png'),
                  ],
                ),
          
                const SizedBox(height: 30,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
              
          
                  
                  
                  
                  
                  
                  
                  
                  
            ]),
          ),
        ),
      ),
    );
  }
}