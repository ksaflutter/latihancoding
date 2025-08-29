import 'package:flutter/material.dart';

import '../models/character.dart';
import '../services/api_service.dart';

class ApiCharactersScreenAll1 extends StatefulWidget {
  const ApiCharactersScreenAll1({super.key});

  @override
  State<ApiCharactersScreenAll1> createState() =>
      _ApiCharactersScreenAll1State();
}

class _ApiCharactersScreenAll1State extends State<ApiCharactersScreenAll1> {
  List<Character> _characters = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final characters = await ApiServiceAll1.getCharacters();
      setState(() {
        _characters = characters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCharacters,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading characters',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadCharacters,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadCharacters,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _characters.length,
                    itemBuilder: (context, index) {
                      final character = _characters[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: character.image != null &&
                                  character.image!.isNotEmpty
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(character.image!),
                                  onBackgroundImageError: (_, __) {},
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    character.name[0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                          title: Text(
                            character.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (character.alternateNames != null)
                                Text(
                                    'Also known as: ${character.alternateNames}'),
                              if (character.house != null &&
                                  character.house!.isNotEmpty)
                                Text('House: ${character.house}'),
                              if (character.actor != null &&
                                  character.actor!.isNotEmpty)
                                Text('Actor: ${character.actor}'),
                            ],
                          ),
                          isThreeLine: true,
                          onTap: () {
                            _showCharacterDetails(character);
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  void _showCharacterDetails(Character character) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(character.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (character.image != null && character.image!.isNotEmpty)
                Center(
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(character.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              _buildDetailItem('Species', character.species),
              _buildDetailItem('Gender', character.gender),
              _buildDetailItem('House', character.house),
              _buildDetailItem('Date of Birth', character.dateOfBirth),
              _buildDetailItem('Year of Birth', character.yearOfBirth),
              _buildDetailItem('Ancestry', character.ancestry),
              _buildDetailItem('Eye Colour', character.eyeColour),
              _buildDetailItem('Hair Colour', character.hairColour),
              _buildDetailItem('Patronus', character.patronus),
              _buildDetailItem('Actor', character.actor),
              if (character.wizard != null)
                _buildDetailItem('Wizard', character.wizard! ? 'Yes' : 'No'),
              if (character.alive != null)
                _buildDetailItem('Alive', character.alive! ? 'Yes' : 'No'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
