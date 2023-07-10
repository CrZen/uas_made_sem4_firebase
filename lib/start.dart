import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final databaseReference = FirebaseDatabase.instance.ref();
  late DatabaseReference doorLocksReference;

  bool isDoorLocked1 = false;
  bool isDoorLocked2 = false;
  bool isDoorLocked3 = false;

  @override
  void initState() {
    super.initState();
    doorLocksReference = databaseReference.child('doorLocks');
    doorLocksReference.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.value != null) {
        var doorLocks = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          isDoorLocked1 = doorLocks['door1'] ?? false;
          isDoorLocked2 = doorLocks['door2'] ?? false;
          isDoorLocked3 = doorLocks['door3'] ?? false;
        });
      }
    });
  }

  @override
  void dispose() {
    doorLocksReference.onDisconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Door lock',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              SwitchListTile(
                title: Text(isDoorLocked1 ? 'Locked' : 'Unlocked'),
                value: isDoorLocked1,
                onChanged: (bool value) {
                  setState(() {
                    isDoorLocked1 = value;
                  });
                  doorLocksReference.update({'door1': value});
                },
                secondary: Icon(isDoorLocked1 ? Icons.lock : Icons.lock_open),
              ),
              SwitchListTile(
                title: Text(isDoorLocked2 ? 'Locked' : 'Unlocked'),
                value: isDoorLocked2,
                onChanged: (bool value) {
                  setState(() {
                    isDoorLocked2 = value;
                  });
                  doorLocksReference.update({'door2': value});
                },
                secondary: Icon(isDoorLocked2 ? Icons.lock : Icons.lock_open),
              ),
              SwitchListTile(
                title: Text(isDoorLocked3 ? 'Locked' : 'Unlocked'),
                value: isDoorLocked3,
                onChanged: (bool value) {
                  setState(() {
                    isDoorLocked3 = value;
                  });
                  doorLocksReference.update({'door3': value});
                },
                secondary: Icon(isDoorLocked3 ? Icons.lock : Icons.lock_open),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
