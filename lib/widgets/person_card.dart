import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/api_service.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  final VoidCallback onTap;

  const PersonCard({
    super.key,
    required this.person,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiService().getImageUrl(person.profilePath);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: imageUrl.isEmpty
                  ? const Center(child: Icon(Icons.person, size: 70))
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, __, ___) =>
                          const Center(child: Icon(Icons.broken_image, size: 50)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                person.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
