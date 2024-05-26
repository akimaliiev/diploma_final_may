// ignore_for_file: use_build_context_synchronously

import 'package:diploma_16_10/components/my_button.dart';
import 'package:diploma_16_10/components/my_textfield.dart';
import 'package:diploma_16_10/components/square_tile.dart';
import 'package:diploma_16_10/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async{
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
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
                SizedBox(height: 50,),
                Icon(
                  Icons.lock,
                  size: 100,
                ),
          
                SizedBox(height: 50,),
          
                Text(
                  'Welcome back! You\'ve been missed',
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
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600])
                        ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25,),
          
                MyButton(
                  onTap: signUserIn,
                  text: 'Sign In',
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
                      onTap: () => AuthService().signInWithGoogle(),
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
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now!',
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