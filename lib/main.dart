import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  await Hive.initFlutter();
  // Register User Adapter
  Hive.registerAdapter(UserAdapter());

  // Open the box to store User data
  await Hive.openBox<User>('userBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hive TypeAdapter Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              var userBox = Hive.box<User>('userBox');

              // Create and add User object
              var user = User('John Doe', 30);
              await userBox.add(user);

              // Retrieve User object
              User? retrievedUser = userBox.getAt(0);  // Notice the '?' here
              if (retrievedUser != null) {
                print('User: ${retrievedUser.name}, Age: ${retrievedUser.age}');
              } else {
                print('No user found.');
              }
            },
            child: Text('Save and Retrieve Data'),
          )
          ,
        ),
      ),
    );
  }
}
