import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_getx_api_demo/sccreen/data_screen/data_screen.dart';
import 'package:provider_getx_api_demo/sccreen/userprovider/profile_screen.dart';

import 'user_provider.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchOnStart());
  }

  Future<void> _fetchOnStart() async {
    setState(() => _isLoading = true);
    await Provider.of<UserProvider>(context, listen: false).fetchUsers();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return RefreshIndicator(
      onRefresh: () {
        return userProvider.fetchUsers();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.skip_next),
            )
          ],
        ),
        body: userProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            // : userProvider.error != null
            //     ? Center(child: Text('Error: ${userProvider.error}'))
            : ListView.builder(
                itemCount: userProvider.users.length,
                itemBuilder: (context, index) {
                  final user = userProvider.users[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user.id.toString())),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () {
                      print("User ID ==> ${user.id}");
                      print("User Name ==> ${user.name}");
                      print("User Email ==> ${user.email}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(user: user),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
