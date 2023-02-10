import 'package:flutter/material.dart';
import '../service_model.dart';
import '../widgets/list_item_widget.dart';
import '../api_service.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen>
    with AutomaticKeepAliveClientMixin<RecordsScreen> {
  late Future<List<Service>> futureService;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureService = fetchServices();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Center(
            child: FutureBuilder<List<Service>>(
              future: futureService,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final services = snapshot.data!;
                  return buildList(services);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildList(List<Service> services) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          futureService = fetchServices();
        });
      },
      child: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ListItem(service: service);
        },
      ),
    );
  }
}
