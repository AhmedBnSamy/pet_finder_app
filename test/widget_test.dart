import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_finder_app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/pet_cubit/pet_cubit.dart';

// Mock classes for dependencies
class MockPetCubit extends Mock implements PetCubit {}
class MockFavoritesCubit extends Mock implements FavoritesCubit {}

void main() {
  late MockPetCubit mockPetCubit;
  late MockFavoritesCubit mockFavoritesCubit;

  setUp(() {
    mockPetCubit = MockPetCubit();
    mockFavoritesCubit = MockFavoritesCubit();
  });

  testWidgets('App should render without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<PetCubit>.value(value: mockPetCubit),
          BlocProvider<FavoritesCubit>.value(value: mockFavoritesCubit),
        ],
        child: const PetFinderApp(),
      ),
    );

    // Verify that the app title is shown
    expect(find.text('PetFinder'), findsOneWidget);
  });
}
