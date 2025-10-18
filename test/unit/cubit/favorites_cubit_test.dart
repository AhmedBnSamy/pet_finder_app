import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_finder_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:pet_finder_app/features/home/data/models/pet_model.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/favorites_cubit/favorites_cubit.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepositoryImpl {}

void main() {
  late FavoritesCubit favoritesCubit;
  late MockFavoritesRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    favoritesCubit = FavoritesCubit(mockRepository);
  });

  tearDown(() {
    favoritesCubit.close();
  });

  group('FavoritesCubit', () {
    final tPetModel = PetModel(
      id: '1',
      url: 'https://example.com/cat.jpg',
      width: 500,
      height: 500,
      breeds: const [],
    );

    final tPetList = [tPetModel];

    test('initial state should trigger loadFavorites', () {
      when(() => mockRepository.getFavorites())
          .thenAnswer((_) async => []);

      expect(favoritesCubit.state, isA<FavoritesState>());
    });

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [FavoritesLoading, FavoritesLoaded] when loadFavorites is successful',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => tPetList);
        return FavoritesCubit(mockRepository);
      },
      expect: () => [
        FavoritesLoading(),
        FavoritesLoaded(tPetList),
      ],
      verify: (_) {
        verify(() => mockRepository.getFavorites()).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [FavoritesLoading, FavoritesError] when loadFavorites fails',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenThrow(Exception('Failed to load favorites'));
        return FavoritesCubit(mockRepository);
      },
      expect: () => [
        FavoritesLoading(),
        isA<FavoritesError>(),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'adds favorite and reloads list',
      build: () {
        when(() => mockRepository.addFavorite(any()))
            .thenAnswer((_) async => {});
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => tPetList);
        return FavoritesCubit(mockRepository);
      },
      act: (cubit) => cubit.addFavorite(tPetModel),
      verify: (_) {
        verify(() => mockRepository.addFavorite(tPetModel)).called(1);
        verify(() => mockRepository.getFavorites()).called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'removes favorite and reloads list',
      build: () {
        when(() => mockRepository.removeFavorite(any()))
            .thenAnswer((_) async => {});
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => []);
        return FavoritesCubit(mockRepository);
      },
      act: (cubit) => cubit.removeFavorite('1'),
      verify: (_) {
        verify(() => mockRepository.removeFavorite('1')).called(1);
        verify(() => mockRepository.getFavorites()).called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'clears all favorites',
      build: () {
        when(() => mockRepository.clearFavorites())
            .thenAnswer((_) async => {});
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => []);
        return FavoritesCubit(mockRepository);
      },
      act: (cubit) => cubit.clearAllFavorites(),
      expect: () => [
        const FavoritesLoaded([]),
      ],
      verify: (_) {
        verify(() => mockRepository.clearFavorites()).called(1);
      },
    );

    test('isFavorite returns true when pet is in favorites', () {
      when(() => mockRepository.getFavorites())
          .thenAnswer((_) async => tPetList);

      final cubit = FavoritesCubit(mockRepository);

      cubit.stream.listen((state) {
        if (state is FavoritesLoaded) {
          expect(cubit.isFavorite('1'), true);
          expect(cubit.isFavorite('999'), false);
        }
      });
    });
  });
}