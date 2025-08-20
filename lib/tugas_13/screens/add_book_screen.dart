import 'package:flutter/material.dart';
import 'package:flutter_application_1/tugas_13/db/db_helper.dart';

import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});
  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _totalPagesController = TextEditingController();
  final _currentPageController = TextEditingController();
  String _selectedGenre = 'Fiksi';
  String _selectedStatus = 'to_read';
  bool _isLoading = false;
  final List<String> _genres = [
    'Fiksi',
    'Non-Fiksi',
    'Romance',
    'Mystery',
    'Fantasy',
    'Sci-Fi',
    'Biography',
    'History',
    'Self-Help',
    'Educational',
    'Comic',
    'Poetry',
    'Other',
  ];
  final List<Map<String, String>> _statusOptions = [
    {'value': 'to_read', 'label': 'Belum Dibaca'},
    {'value': 'reading', 'label': 'Sedang Dibaca'},
    {'value': 'completed', 'label': 'Selesai'},
  ];
  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _totalPagesController.dispose();
    _currentPageController.dispose();
    super.dispose();
  }

  Future<void> _saveBook() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final book = Book(
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        description: _descriptionController.text.trim(),
        genre: _selectedGenre,
        totalPages: int.parse(_totalPagesController.text),
        currentPage: int.parse(_currentPageController.text.isEmpty
            ? '0'
            : _currentPageController.text),
        status: _selectedStatus,
        dateAdded: DateTime.now(),
        dateCompleted: _selectedStatus == 'completed' ? DateTime.now() : null,
      );
      await DatabaseHelper.instance.createBook(book);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Buku berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error menambah buku: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Buku'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveBook,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Book Cover Preview
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/images_book_9.jpg"),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    size: 48,
                    color: const Color.fromARGB(255, 19, 69, 110),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tambah buku anda',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 16, 130, 223),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Buku *',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Judul buku tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Current Page Field (only show if reading)
            if (_selectedStatus == 'reading') ...[
              TextFormField(
                controller: _currentPageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Halaman Saat Ini',
                  prefixIcon: Icon(Icons.bookmark_outline),
                  hintText: '0',
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final currentPage = int.tryParse(value);
                    final totalPages = int.tryParse(_totalPagesController.text);
                    if (currentPage == null || currentPage < 0) {
                      return 'Halaman saat ini harus berupa angka positif';
                    }
                    if (totalPages != null && currentPage > totalPages) {
                      return 'Halaman saat ini tidak boleh melebihi total halaman';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
            ],
            // Description Field
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Deskripsi tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 243, 218, 77), // ubah dekorasi button
                  foregroundColor: const Color.fromARGB(255, 4, 91, 163),
                ),
                onPressed: _isLoading ? null : _saveBook,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Simpan Buku',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            // Cancel Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text(
                  'Batal',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            // Author Field
            const SizedBox(height: 16),
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Penulis *',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Penulis tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Genre Dropdown
            DropdownButtonFormField<String>(
              value: _selectedGenre,
              decoration: const InputDecoration(
                labelText: 'Genre',
                prefixIcon: Icon(Icons.category),
              ),
              items: _genres.map((genre) {
                return DropdownMenuItem(
                  value: genre,
                  child: Text(genre),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGenre = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            // Total Pages Field
            TextFormField(
              controller: _totalPagesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Halaman *',
                prefixIcon: Icon(Icons.pages),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Total halaman tidak boleh kosong';
                }
                final pages = int.tryParse(value);
                if (pages == null || pages <= 0) {
                  return 'Total halaman harus berupa angka positif';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Status Dropdown
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status Baca',
                prefixIcon: Icon(Icons.bookmark),
              ),
              items: _statusOptions.map((status) {
                return DropdownMenuItem(
                  value: status['value'],
                  child: Text(status['label']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
