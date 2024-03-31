import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wake_client/client_repository.dart';
import 'package:wake_client/get_it.dart';
import 'package:wake_client/models/pc_status.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wake Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wake Client'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;

  bool _isOnline = false;

  String _message = "Checking for PC status";

  @override
  initState() {
    super.initState();
    _onRefresh();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
      _message = "Checking for PC status";
    });
    final pcStatus = await getIt.get<ClientRepository>().isServerOnline();
    setState(() {
      _isLoading = false;
      _isOnline = pcStatus.status.value == PcStatus.ONLINE;
      _message = _isOnline ? "PC is online" : "PC is not online";
    });
  }

  Future<void> _onPower() async {
    setState(() {
      _message = "Power on the PC";
      _isOnline = false;
    });
    final logs = await getIt.get<ClientRepository>().powerOn();
    setState(() {
      _message = logs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          reverse: true,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _onPower,
                    icon: Icon(
                      Icons.power_settings_new,
                      size: 60,
                      color: _isOnline ? Colors.green : Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const SizedBox(
                              width: 1,
                              height: 1,
                            ),
                    ),
                  ),
                  Text(_message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
