import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_requests_demo/screen/all_users_screen.dart';
import 'package:http_requests_demo/screen/single_user_screen.dart';

import '../models/create_user.dart';
import '../models/user_details_list.dart';
import '../models/single_user_details.dart';
import '../widgets/display_all_users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SingleUserDetails> userDetails = [];
  List<UserDetailsList> allUsers = [];
  bool _isUserDetailsEmpty = true;

  final _id = TextEditingController();
  final _name = TextEditingController();
  final _job = TextEditingController();

  //Method for SingleUserDetails Model
  void _getSingleUser() async {
    const url = 'https://reqres.in/api/users/2';

    final response = await http.get(Uri.parse(url));

    print(response);
    print(response.body);
    print(json.decode(response.body));

    final details = SingleUserDetails.fromJson(json.decode(response.body));

    setState(() {
      userDetails.add(details);
      _isUserDetailsEmpty = false;
    });

    Navigator.of(context).pushNamed(
      SingleUserScreen.routeName,
      arguments: userDetails,
    );

    print('UserDetails Length: ${userDetails.length}');
  }

  //Method for UserDetailsList Model
  void _getAllUserDetails() async {
    const url = 'https://reqres.in/api/unknown';
    final response = await http.get(Uri.parse(url));
    print(response);
    print(response.body);
    final result = UserDetailsList.fromJson(json.decode(response.body));
    List<UserDetailsList> user = [];
    setState(() {
      user.add(result);
    });
    Navigator.of(context).pushNamed(AllUsersScreen.routeName, arguments: user);
  }

  void _sendPostHttpRequest() async {
    const url = 'https://reqres.in/api/users';
    CreateUser user = CreateUser(id: _id.text, name: _name.text, job: _job.text, createdAt: DateTime.now().toString());
    final bodyInJson = user.toJson();
    await http.post(Uri.parse(url), body: bodyInJson).whenComplete(() {
      print('POST REQUEST COMPLETED!!');
    });
    Navigator.of(context).pop();
  }

  void _openUserCreationForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(20),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _id,
              decoration: InputDecoration(labelText: 'Id'),
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _job,
              decoration: InputDecoration(labelText: 'Job'),
            ),
            TextButton.icon(
              onPressed: _sendPostHttpRequest,
              icon: Icon(Icons.send_outlined),
              label: Text(''),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose any one!'),
      ),
      body: Container(
        height: 500,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: _getSingleUser,
                    child: const Text('GET Single User')),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: _getAllUserDetails,
                    child: const Text('GET List Resource')),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _openUserCreationForm,
                child: Text('POST HTTP Request')),
          ],
        ),
      ),
    );
  }
}
