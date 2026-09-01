import '../models/person.dart';

class FavoritesService {
  static final List<Person> _favorites = [];

  static List<Person> get favorites => List.unmodifiable(_favorites);

  static bool isFavorite(int personId) {
    return _favorites.any((person) => person.id == personId);
  }

  static void toggleFavorite(Person person) {
    if (isFavorite(person.id)) {
      _favorites.removeWhere(
            (favorite) => favorite.id == person.id,
      );
    } else {
      _favorites.add(person);
    }
  }
}