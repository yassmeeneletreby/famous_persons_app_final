import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'image_viewer_screen.dart';

class PersonDetailsScreen extends StatefulWidget {
  final int personId;

  const PersonDetailsScreen({
    super.key,
    required this.personId,
  });

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  Map<String, dynamic>? personDetails;
  List<dynamic> personImages = [];

  bool isLoading = true;
  String? errorMessage;

  final String apiKey =
      '2dfe23358236069710a379edd4c65a6b';

  @override
  void initState() {
    super.initState();
    fetchPersonData();
  }

  Future<void> fetchPersonData() async {
    try {
      final detailsUrl = Uri.parse(
        'https://api.themoviedb.org/3/person/${widget.personId}?api_key=$apiKey',
      );

      final imagesUrl = Uri.parse(
        'https://api.themoviedb.org/3/person/${widget.personId}/images?api_key=$apiKey',
      );

      final detailsResponse = await http.get(detailsUrl);
      final imagesResponse = await http.get(imagesUrl);

      if (detailsResponse.statusCode != 200 ||
          imagesResponse.statusCode != 200) {
        throw Exception('Failed to load person data');
      }

      final detailsData = jsonDecode(detailsResponse.body);
      final imagesData = jsonDecode(imagesResponse.body);

      if (!mounted) return;

      setState(() {
        personDetails = detailsData;
        personImages = imagesData['profiles'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage =
        'Something went wrong. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(errorMessage!),
      );
    }

    if (personDetails == null) {
      return const Center(
        child: Text('No data available'),
      );
    }

    final String name =
        personDetails!['name'] ?? 'Unknown';

    final String biography =
        personDetails!['biography'] ??
            'No biography available.';

    final String? profilePath =
    personDetails!['profile_path'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          // Main Profile Image
          if (profilePath != null)
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ImageViewerScreen(
                            imageUrl:
                            'https://image.tmdb.org/t/p/original$profilePath',
                          ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(16),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500$profilePath',
                    height: 300,
                    width: 200,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                      return const SizedBox(
                        height: 300,
                        width: 200,
                        child: Icon(
                          Icons.person,
                          size: 100,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),

          // Name
          Text(
            name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Biography Title
          const Text(
            'Biography',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Biography
          Text(
            biography,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 25),

          // Photos Title
          const Text(
            'Photos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // Photos
          personImages.isEmpty
              ? const Text('No photos available.')
              : GridView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: personImages.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder:
                (context, index) {
              final imagePath =
              personImages[index]
              ['file_path'];

              if (imagePath == null) {
                return const Icon(
                  Icons.image_not_supported,
                );
              }

              final imageUrl =
                  'https://image.tmdb.org/t/p/original$imagePath';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ImageViewerScreen(
                            imageUrl: imageUrl,
                          ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(12),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500$imagePath',
                    fit: BoxFit.cover,
                    errorBuilder: (
                        context,
                        error,
                        stackTrace,
                        ) {
                      return const Icon(
                        Icons.broken_image,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}