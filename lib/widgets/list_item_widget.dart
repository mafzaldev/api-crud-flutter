import 'package:flutter/material.dart';
import '../screens/update_record_screen.dart';
import '../service_model.dart';
import '../api_service.dart';

class ListItem extends StatelessWidget {
  final Service service;

  const ListItem({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateRecord(
                            id: service.id,
                            title: service.title,
                            description: service.description,
                            status: service.status == "Active" ? true : false,
                          )));
            },
            leading: service.status == 'Active'
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("${service.id}. ${service.title}",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0)),
            ),
            subtitle: Text(service.description,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0)),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                Future<String> deleteResponse = deleteService(service.id);
                String response = await deleteResponse;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
