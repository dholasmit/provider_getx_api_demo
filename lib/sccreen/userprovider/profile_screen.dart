import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final dynamic user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Text(user.id.toString())),
            title: Text(user.name),
            subtitle: Text(user.email),
          ),
        ],
      ),
    );
  }
}
