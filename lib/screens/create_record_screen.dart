import 'package:flutter/material.dart';
import '../api_service.dart';

class InsertRecord extends StatefulWidget {
  const InsertRecord({super.key});

  @override
  InsertRecordState createState() {
    return InsertRecordState();
  }
}

class InsertRecordState extends State<InsertRecord> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Create Record",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    labelText: "Title",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    fillColor: Colors.white70),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                      labelText: "Description",
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey[800]),
                      fillColor: Colors.white70),
                  maxLines: 100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Status'),
                  Switch(
                    value: status,
                    onChanged: (bool value) {
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50.0,
                width: 320.0,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Future<String> postResponse = postService(
                          titleController.text,
                          descriptionController.text,
                          status ? "Active" : "Inactive");
                      String response = await postResponse;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response)),
                      );
                    }
                    titleController.clear();
                    descriptionController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Submit',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
