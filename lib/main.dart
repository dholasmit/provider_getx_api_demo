import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sccreen/userprovider/user_list_screen.dart';
import 'sccreen/userprovider/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider API Demo',
      home: UserListPage(),
    );
  }
}
