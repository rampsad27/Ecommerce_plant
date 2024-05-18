import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Icon(Icons.border_all), actions: const [
        Icon(Icons.linear_scale_sharp),
        Icon(Icons.notification_important_sharp),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Morning",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const Text("Find your favourite plants here"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            const Row(
              children: [
                Text(
                  "Most Popular",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text("View all")
              ],
            ),
            const Row(
              children: [
                Text(
                  "My Favourite",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text("View all")
              ],
            )
          ],
        ),
      ),
    );
  }
}