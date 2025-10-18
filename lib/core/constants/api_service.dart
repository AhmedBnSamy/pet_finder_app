import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/home/data/models/pet_model.dart';
import '../constants/api_constants.dart';


@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/images/search')
  Future<List<PetModel>> getPets(
      @Query('limit') int limit,
      @Query('page') int page,
      @Query('has_breeds') int hasBreeds,
      );

  @GET('/images/search')
  Future<List<PetModel>> searchPetsByBreed(
      @Query('breed_ids') String breedId,
      @Query('limit') int limit,
      );

  @GET('/breeds')
  Future<List<BreedModel>> getBreeds();

  @GET('/images/{imageId}')
  Future<PetModel> getPetById(@Path('imageId') String imageId);
}

// Dio Factory
class DioFactory {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: ApiConstants.headers,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // Add Interceptors for logging
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    return dio;
  }
}