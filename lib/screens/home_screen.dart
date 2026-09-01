import 'package:flutter/material.dart';

import '../models/person.dart';
import '../services/api_service.dart';
import '../services/favorites_service.dart';
import '../widgets/person_card.dart';
import 'person_details_screen.dart';
import 'chat_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  late Future<List<Person>> _personsFuture;

  @override
  void initState() {
    super.initState();
    _loadPersons();
  }

  void _loadPersons() {
    _personsFuture = _apiService.getPopularPersons();
  }

  void _retry() {
    setState(_loadPersons);
  }

  void _toggleFavorite(Person person) {
    setState(() {
      FavoritesService.toggleFavorite(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Famous Persons'),
        centerTitle: true,
        actions: [
          // Favorites
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            tooltip: 'Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),

          // AI Chat
          IconButton(
            icon: const Icon(Icons.smart_toy_outlined),
            tooltip: 'AI Chat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder<List<Person>>(
        future: _personsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Something went wrong.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _retry,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final persons = snapshot.data ?? [];

          if (persons.isEmpty) {
            return const Center(
              child: Text('No persons found.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: persons.length,
            itemBuilder: (context, index) {
              final person = persons[index];

              final isFavorite =
              FavoritesService.isFavorite(person.id);

              return Stack(
                children: [
                  PersonCard(
                    person: person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PersonDetailsScreen(
                                personId: person.id,
                              ),
                        ),
                      );
                    },
                  ),

                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: 0.2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          _toggleFavorite(person);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}