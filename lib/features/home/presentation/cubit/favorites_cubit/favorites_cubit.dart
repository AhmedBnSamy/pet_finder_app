import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/pet_model.dart';
import '../../../../favorites/data/repositories/favorites_repository_impl.dart';


part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepositoryImpl repository;

  FavoritesCubit(this.repository) : super(FavoritesInitial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      emit(FavoritesLoading());
      final favorites = await repository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> addFavorite(PetModel pet) async {
    try {
      await repository.addFavorite(pet);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavorite(String petId) async {
    try {
      await repository.removeFavorite(petId);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> clearAllFavorites() async {
    try {
      await repository.clearFavorites();
      emit(const FavoritesLoaded([]));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String petId) {
    if (state is FavoritesLoaded) {
      return (state as FavoritesLoaded).favorites.any((pet) => pet.id == petId);
    }
    return false;
  }
}