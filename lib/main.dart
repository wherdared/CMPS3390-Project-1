import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const IndecisionView());
  }
}

class IndecisionView extends StatefulWidget {
  const IndecisionView({super.key});

  @override
  State<IndecisionView> createState() => _IndecisionViewState();
}

class _IndecisionViewState extends State<IndecisionView> {
  List<String> choices = [];
  int? selectedIndex; // ? means it can be null (nothing selected)
  final TextEditingController optionController = TextEditingController();
  final FocusNode optionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Choices'),
          ElevatedButton(
            onPressed: () {
              if (choices.isNotEmpty) {
                final randomChoice = choices[Random().nextInt(choices.length)];
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(randomChoice),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Okay'),
                          
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Make Choice!'),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: choices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(choices[index]),
                    selected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          const Text('Option:'),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Enter Option',
            ),
            controller: optionController,
            focusNode: optionFocusNode,
          ),
          ElevatedButton(
            onPressed: () {
              if (optionController.text.isNotEmpty) {
                setState(() {
                  choices.add(optionController.text);
                  optionController.clear();
                  optionFocusNode.requestFocus();
                });
              }
            },
            child: const Text('Add'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedIndex != null) {
                setState(() {
                  choices.removeAt(selectedIndex!);
                  selectedIndex = null;
                });
              }
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
