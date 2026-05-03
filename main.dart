import 'package:flutter/material.dart';

void main() {
  runApp(const JournalApp());
}

class JournalApp extends StatelessWidget {
  const JournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const JournalPage(),
    );
  }
}

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  List<Map<String, String>> notes = [];

  void addNote() {
    if (titleController.text.isEmpty || descController.text.isEmpty) return;

    setState(() {
      notes.add({
        "title": titleController.text,
        "desc": descController.text,
        "date": DateTime.now().toString().substring(0, 16),
      });
    });

    titleController.clear();
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addNote,
              child: const Text("Add Entry"),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: notes.isEmpty
                  ? const Center(
                child: Text("No Entries Yet"),
              )
                  : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notes[index]["title"]!),
                      subtitle: Text(
                        "${notes[index]["desc"]}\n${notes[index]["date"]}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}