import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_finder_app/features/home/data/models/pet_model.dart';
import 'package:pet_finder_app/features/home/data/repositories/pet_repository_impl.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/pet_cubit/pet_cubit.dart';

// Mock Repository
class MockPetRepository extends Mock implements PetRepositoryImpl {}

void main() {
  late PetCubit petCubit;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    petCubit = PetCubit(mockRepository);
  });

  tearDown(() {
    petCubit.close();
  });

  group('PetCubit', () {
    final tPetModel = PetModel(
      id: '1',
      url: 'https://example.com/cat.jpg',
      width: 500,
      height: 500,
      breeds: const [],
    );

    final tPetList = [tPetModel];

    test('initial state should be PetInitial', () {
      expect(petCubit.state, PetInitial());
    });

    blocTest<PetCubit, PetState>(
      'emits [PetLoading, PetLoaded] when fetchPets is successful',
      build: () {
        when(() => mockRepository.getPets(page: any(named: 'page'), limit: any(named: 'limit')))
            .thenAnswer((_) async => tPetList);
        return petCubit;
      },
      act: (cubit) => cubit.fetchPets(),
      expect: () => [
        PetLoading(),
        PetLoaded(tPetList),
      ],
      verify: (_) {
        verify(() => mockRepository.getPets(page: 0, limit: 20)).called(1);
      },
    );

    blocTest<PetCubit, PetState>(
      'emits [PetLoading, PetError] when fetchPets fails',
      build: () {
        when(() => mockRepository.getPets(page: any(named: 'page'), limit: any(named: 'limit')))
            .thenThrow(Exception('Failed to fetch pets'));
        return petCubit;
      },
      act: (cubit) => cubit.fetchPets(),
      expect: () => [
        PetLoading(),
        isA<PetError>(),
      ],
    );

    blocTest<PetCubit, PetState>(
      'emits [PetLoading, PetLoaded] when searchPetsByBreed is successful',
      build: () {
        when(() => mockRepository.searchPetsByBreed(any()))
            .thenAnswer((_) async => tPetList);
        return petCubit;
      },
      act: (cubit) => cubit.searchPetsByBreed('abys'),
      expect: () => [
        PetLoading(),
        PetLoaded(tPetList),
      ],
      verify: (_) {
        verify(() => mockRepository.searchPetsByBreed('abys')).called(1);
      },
    );

    final tBreedModel = BreedModel(
      id: 'abys',
      name: 'Abyssinian',
      temperament: 'Active, Energetic',
      origin: 'Egypt',
    );

    final tBreedList = [tBreedModel];

    blocTest<PetCubit, PetState>(
      'emits [BreedLoading, BreedLoaded] when fetchBreeds is successful',
      build: () {
        when(() => mockRepository.getBreeds())
            .thenAnswer((_) async => tBreedList);
        return petCubit;
      },
      act: (cubit) => cubit.fetchBreeds(),
      expect: () => [
        BreedLoading(),
        BreedLoaded(tBreedList),
      ],
      verify: (_) {
        verify(() => mockRepository.getBreeds()).called(1);
      },
    );
  });
}