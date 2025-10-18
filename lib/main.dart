import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/constants/api_service.dart';
import 'features/home/data/repositories/pet_repository_impl.dart';
import 'features/home/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'features/favorites/data/repositories/favorites_repository_impl.dart';
import 'features/home/presentation/cubit/pet_cubit/pet_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final prefs = await SharedPreferences.getInstance();
  final dio = DioFactory.create();
  final apiService = ApiService(dio);

  // Initialize repositories
  final petRepository = PetRepositoryImpl(apiService);
  final favoritesRepository = FavoritesRepositoryImpl(prefs);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PetCubit(petRepository),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(favoritesRepository),
        ),
      ],
      child: const PetFinderApp(),
    ),
  );
}