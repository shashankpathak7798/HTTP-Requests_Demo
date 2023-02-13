import 'package:flutter/material.dart';
import 'package:http_requests_demo/models/single_user_details.dart';

class SingleUserScreen extends StatelessWidget {
  static const routeName = '/single-user';
  List<SingleUserDetails> userDetails = [];


  void _openBottomModalSheet(BuildContext context, String? avatar, String? firstName,
      String? lastName, String? url, String? description) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 200,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.black,
              ),
              Row(
                children: [
                  Container(height: 40, child: Image.network(avatar!)),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    '${firstName} ${lastName}',
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Text(
                'URl: $url',
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 8,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Text(
                'Description:\n$description',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
        elevation: 4);
  }


  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as List<SingleUserDetails>;
    userDetails = routeArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text('Single User Details'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
                child: Image.network(
                    '${userDetails[index].data?.avatar}')),
            title: Text(
                '${userDetails[index].data?.firstName} ${userDetails[index].data
                    ?.lastName}'),
            subtitle: Text('${userDetails[index].data?.email}'),
            trailing: IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () =>
                  _openBottomModalSheet(
                    context,
                      userDetails[index].data?.avatar,
                      userDetails[index].data?.firstName,
                      userDetails[index].data?.lastName,
                      userDetails[index].support?.url,
                      userDetails[index].support?.text),
            ),
          );
        },
        itemCount: userDetails.length,
      ),
    );
  }
}
