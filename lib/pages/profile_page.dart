 import 'package:diploma_16_10/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState()=>_ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!; 

  Future<void> editField (String field) async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50,),
          const Icon(
            Icons.person,
            size: 72,
          ),
          const SizedBox(height: 10,),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(height: 50,),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          MyTextBox(
            text: 'akimaliiev', 
            sectionName: 'username',
            onPressed: () => editField('username'),
          ),
          MyTextBox(
            text: 'empty bio', 
            sectionName: 'bio',
            onPressed: () => editField('bio'),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
  
}
