import 'package:api_crud/screens/update_record_screen.dart';
import 'package:flutter/material.dart';
import 'screens/view_records_screen.dart';
import 'screens/create_record_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PCC Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('PCC Services'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Records',
                icon: Icon(Icons.list),
              ),
              Tab(
                text: 'Create',
                icon: Icon(Icons.add),
              ),
            ]),
          ),
          body: const TabBarView(
            children: [RecordsScreen(), InsertRecord()],
          ),
        ),
      ),
    );
  }
}
