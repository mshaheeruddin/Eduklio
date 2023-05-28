/*
import 'package:flutter/cupertino.dart';

import '../../data/repositories/general_repository.dart';

class UserId extends StatelessWidget {
  String? userId;
  UserId();

  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return FutureBuilder<String?>(
      future: repository.getUserUID(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        String? data = snapshot.data;
        userId = data;
        return Text(data ?? 'No data'); // Display the retrieved data
      },
    );

  }
}
*/
