import 'package:flutter/material.dart';

import '../models/user_details_list.dart';

class AllUsersScreen extends StatelessWidget {
  static const routeName = '/all-users';
  List<UserDetailsList> userDetails = [];
  var data;


  void _displayBottomModalSheet(BuildContext context, int index) {
    showModalBottomSheet(context: context, builder: ((context) {
      return Container(
        child: Column(children: [
          Text('Id: ${userDetails[index].data?[index].id}'),
          Text('Name: ${userDetails[index].data?[index].name}'),
          Text('Year: ${userDetails[index].data?[index].year}')
        ],),
      );
    }));
  }


  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as List<UserDetailsList>;
    userDetails = routeArgs;

    return Scaffold(
      appBar: AppBar(title: Text('All Users'),),
      body: ListView.builder(itemBuilder: ((context, index) {
        return Card(
          elevation: 5,
          child: ListTile(
            leading: Text('${userDetails[0].data?[index].id}'),
            title: Text('Name: ${userDetails[0].data?[index].name}'),
            subtitle: Text('Year: ${userDetails[0].data?[index].year}'),
            trailing: Text('Color: ${userDetails[0].data?[index].color}'),
          ),
        );
      }), itemCount: userDetails[0].data?.length,),
    );
  }
}
