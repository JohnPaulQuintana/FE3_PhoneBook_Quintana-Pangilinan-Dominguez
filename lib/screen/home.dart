import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:generate_random_user_with_map/screen/LocationMapWidget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // storage for response json
  List<dynamic> users = [];
  // final bool isHovered = false;
  // bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet People Arround the World'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          // final latitude = user['location']['coordinates']['latitude'];
          // final longitude = user['location']['coordinates']['longitude'];
          // final imageUrl = user['picture']['thumbnail'];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationMapWidget(
                        latitude: user['location']['coordinates']['latitude'],
                        longitude: user['location']['coordinates']['longitude'],
                        name: '${user['name']['title']} ${user['name']['first']} ${user['name']['last']}',
                        loc: '${user['location']['city']}, ${user['location']['country']}'
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Center(
                  widthFactor: 0.5,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: _getRandomColor(),
                            child: Text(
                              '${user['name']['first'][0]}'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user['name']['title']} ${user['name']['first']} ${user['name']['last']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${user['dob']['age']} years, joined on ${user['registered']['age']} years old',
                                  style: TextStyle(
                                    color: user['dob']['age'] <= 18
                                        ? Colors.green
                                        : (user['dob']['age'] >= 19 &&
                                                user['dob']['age'] <= 30
                                            ? Colors.orange
                                            : Colors.red),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Email: ${user['email']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Location: ${user['location']['city']}, ${user['location']['country']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Phone: ${user['phone']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          _getGenderIcon(user['gender']),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Icon(Icons.search),
        
        ),
    );
  }

// request to the api
  void fetchUsers() async {
    // print("dwadwadawd");
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });

    // print(users);
    print('fetchUsers completed');
  }
}

// gender icon
_getGenderIcon(gender) {
  // print(gender);
  if (gender == 'male') {
    return const Icon(
      Icons.male,
      color: Color.fromARGB(179, 15, 145, 231),
      size: 30,
    );
  } else {
    return const Icon(
      Icons.female,
      color: Color.fromARGB(255, 211, 116, 163),
      size: 30,
    );
  }
}

// random color
_getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
