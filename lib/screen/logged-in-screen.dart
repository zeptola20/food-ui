// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:food_ui1/controllers/google-signin-provider.dart';

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged in'),
        actions: [
          TextButton(
              onPressed: () =>
                Get.find  <GooogleSignInProvider>()
                      .logout(),
              child: const Text('Logout'))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile'),
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user!.photoURL.toString()),
            ),
            const SizedBox(
              height: 40,
            ),
            Text('Name:${user.displayName}'),
            const SizedBox(
              height: 40,
            ),
            Text('Email:${user.email}'),
            MaterialButton(
                onPressed: () => Get.toNamed('/home_screen',),
                child: const Text('Go to home ')),
          ],
        ),
      ),
    );
  }
}
