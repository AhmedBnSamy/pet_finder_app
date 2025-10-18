import '../../../../core/constants/api_service.dart';
import '../models/pet_model.dart';

class PetRepositoryImpl {
  final ApiService apiService;

  PetRepositoryImpl(this.apiService);

  Future<List<PetModel>> getPets({
    int page = 0,
    int limit = 20,
  }) async {
    try {
      final pets = await apiService.getPets(limit, page, 1);
      return pets;
    } catch (e) {
      throw Exception('Failed to fetch pets: $e');
    }
  }

  Future<List<PetModel>> searchPetsByBreed(String breedId) async {
    try {
      final pets = await apiService.searchPetsByBreed(breedId, 20);
      return pets;
    } catch (e) {
      throw Exception('Failed to search pets by breed: $e');
    }
  }

  Future<List<BreedModel>> getBreeds() async {
    try {
      final breeds = await apiService.getBreeds();
      return breeds;
    } catch (e) {
      throw Exception('Failed to fetch breeds: $e');
    }
  }

  Future<PetModel> getPetById(String imageId) async {
    try {
      final pet = await apiService.getPetById(imageId);
      return pet;
    } catch (e) {
      throw Exception('Failed to fetch pet details: $e');
    }
  }
}