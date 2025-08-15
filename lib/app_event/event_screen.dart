import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'event_model.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _eventController =
      TextEditingController(text: "Aktivitas Sehari-hari");
  final TextEditingController _kotaController = TextEditingController();
  List<EventModel> _eventList = [];
  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async {
    final data = await DBHelper().getEvents();
    setState(() {
      _eventList = data;
    });
  }

  void _saveEvent() async {
    if (_formKey.currentState!.validate()) {
      final event = EventModel(
        nama: _namaController.text,
        email: _emailController.text,
        event: _eventController.text,
        kota: _kotaController.text,
      );
      await DBHelper().insertEvent(event);
      _namaController.clear();
      _emailController.clear();
      _eventController.text = "Aktivitas Sehari-hari";
      _kotaController.clear();
      _fetchEvents();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil disimpan")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration:
                        const InputDecoration(labelText: "Nama Peserta"),
                    validator: (value) =>
                        value!.isEmpty ? "Nama wajib diisi" : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) {
                      if (value!.isEmpty) return "Email wajib diisi";
                      if (!value.contains('@')) return "Email tidak valid";
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _eventController,
                    decoration: const InputDecoration(labelText: "Nama Event"),
                    validator: (value) =>
                        value!.isEmpty ? "Event wajib diisi" : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _kotaController,
                    decoration: const InputDecoration(labelText: "Asal Kota"),
                    validator: (value) =>
                        value!.isEmpty ? "Kota wajib diisi" : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _saveEvent,
                    child: const Text("Simpan"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _eventList.isEmpty
                  ? const Center(child: Text("Belum ada data"))
                  : ListView.builder(
                      itemCount: _eventList.length,
                      itemBuilder: (context, index) {
                        final item = _eventList[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.nama),
                            subtitle: Text(
                                "${item.email} | ${item.event} | ${item.kota}"),
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
