import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../home/data/models/pet_model.dart';

class FavoritesRepositoryImpl {
  static const String _favoritesKey = 'favorites_pets';
  final SharedPreferences prefs;

  FavoritesRepositoryImpl(this.prefs);

  Future<List<PetModel>> getFavorites() async {
    try {
      final String? favoritesJson = prefs.getString(_favoritesKey);
      if (favoritesJson == null) return [];

      final List<dynamic> decoded = json.decode(favoritesJson);
      return decoded.map((json) => PetModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load favorites: $e');
    }
  }

  Future<void> addFavorite(PetModel pet) async {
    try {
      final favorites = await getFavorites();

      // Check if already exists
      if (favorites.any((p) => p.id == pet.id)) {
        return;
      }

      favorites.add(pet);
      final String encoded = json.encode(
        favorites.map((pet) => pet.toJson()).toList(),
      );
      await prefs.setString(_favoritesKey, encoded);
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  Future<void> removeFavorite(String petId) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((pet) => pet.id == petId);

      final String encoded = json.encode(
        favorites.map((pet) => pet.toJson()).toList(),
      );
      await prefs.setString(_favoritesKey, encoded);
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  Future<void> clearFavorites() async {
    try {
      await prefs.remove(_favoritesKey);
    } catch (e) {
      throw Exception('Failed to clear favorites: $e');
    }
  }

  Future<bool> isFavorite(String petId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((pet) => pet.id == petId);
    } catch (e) {
      return false;
    }
  }
}