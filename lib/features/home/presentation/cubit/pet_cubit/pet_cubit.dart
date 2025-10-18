import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/repositories/pet_repository_impl.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final PetRepositoryImpl repository;

  PetCubit(this.repository) : super(PetInitial());

  Future<void> fetchPets({int page = 0, int limit = 20}) async {
    try {
      emit(PetLoading());
      final pets = await repository.getPets(page: page, limit: limit);
      emit(PetLoaded(pets));
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> searchPetsByBreed(String breedId) async {
    try {
      emit(PetLoading());
      final pets = await repository.searchPetsByBreed(breedId);
      emit(PetLoaded(pets));
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> fetchBreeds() async {
    try {
      emit(BreedLoading());
      final breeds = await repository.getBreeds();
      emit(BreedLoaded(breeds));
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }
}