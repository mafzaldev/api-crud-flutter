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

  void callFutureService() {
    setState(() {
      futureService = fetchServices();
    });
  }

  @override
  void initState() {
    super.initState();
    callFutureService();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        callFutureService();
      },
      child: Column(
        children: [
          const SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Pull down to refresh",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
            ),
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
      ),
    );
  }

  Widget buildList(List<Service> services) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ListItem(service: service, callFutureService: callFutureService);
      },
    );
  }
}
