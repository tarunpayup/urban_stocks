import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CheckboxDemo(),
    );
  }
}

class CheckboxDemo extends StatefulWidget {
  const CheckboxDemo({super.key});

  @override
  State<CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> {

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Checkbox Demo"),
      ),

      body: Column(

        children: [

          CheckboxListTile(

            title: const Text("Cricket"),

            value: selectedItems.contains("Anjali"),

            onChanged: (value) {

              setState(() {

                if (value == true) {
                  selectedItems.add("Anjali");
                } else {
                  selectedItems.remove("Cricket");
                }

              });

            },

          ),

          CheckboxListTile(

            title: const Text("Football"),

            value: selectedItems.contains("Football"),

            onChanged: (value) {

              setState(() {

                if (value == true) {
                  selectedItems.add("Football");
                } else {
                  selectedItems.remove("Football");
                }

              });

            },

          ),

          CheckboxListTile(

            title: const Text("Basketball"),

            value: selectedItems.contains("Basketball"),

            onChanged: (value) {

              setState(() {

                if (value == true) {
                  selectedItems.add("Basketball");
                } else {
                  selectedItems.remove("Basketball");
                }

              });

            },

          ),

          CheckboxListTile(

            title: const Text("Tennis"),

            value: selectedItems.contains("Tennis"),

            onChanged: (value) {

              setState(() {

                if (value == true) {
                  selectedItems.add("Tennis");
                } else {
                  selectedItems.remove("Tennis");
                }

              });

            },

          ),

          CheckboxListTile(

            title: const Text("Badminton"),

            value: selectedItems.contains("Badminton"),

            onChanged: (value) {

              setState(() {

                if (value == true) {
                  selectedItems.add("Badminton");
                } else {
                  selectedItems.remove("Badminton");
                }

              });

            },

          ),

          const Divider(),

          const Text(
            "Selected Items:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            selectedItems.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),
    );
  }
}