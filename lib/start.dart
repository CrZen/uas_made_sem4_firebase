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

  bool isDoorLocked1 = false;
  bool isDoorLocked2 = false;
  bool isDoorLocked3 = false;

  @override
  void initState() {
    super.initState();
    initializeDoorLocks();
  }

  Future<void> initializeDoorLocks() async {
    final snapshot1 = await databaseReference.child('doorLocks/door1').once();
    final bool? initialValue1 = snapshot1.snapshot.value as bool?;
    if (initialValue1 != null) {
      setState(() {
        isDoorLocked1 = initialValue1;
      });
    }

    final snapshot2 = await databaseReference.child('doorLocks/door2').once();
    final bool? initialValue2 = snapshot2.snapshot.value as bool?;
    if (initialValue2 != null) {
      setState(() {
        isDoorLocked2 = initialValue2;
      });
    }

    final snapshot3 = await databaseReference.child('doorLocks/door3').once();
    final bool? initialValue3 = snapshot3.snapshot.value as bool?;
    if (initialValue3 != null) {
      setState(() {
        isDoorLocked3 = initialValue3;
      });
    }
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
                  databaseReference.child('doorLocks/door1').set(value);
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
                  databaseReference.child('doorLocks/door2').set(value);
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
                  databaseReference.child('doorLocks/door3').set(value);
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
