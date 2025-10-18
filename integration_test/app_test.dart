import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pet_finder_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PetFinder App Integration Tests', () {
    testWidgets('Complete user flow: Splash -> Onboarding -> Home -> Details -> Favorites',
            (WidgetTester tester) async {
          // Start the app
          app.main();
          await tester.pumpAndSettle();

          // Wait for splash screen
          expect(find.text('PetFinder'), findsOneWidget);
          await tester.pumpAndSettle(const Duration(seconds: 4));

          // Should be on onboarding screen
          expect(find.text('Discover Pets'), findsOneWidget);

          // Tap next button
          await tester.tap(find.text('Next'));
          await tester.pumpAndSettle();

          expect(find.text('Filter by Breed'), findsOneWidget);

          // Tap next button again
          await tester.tap(find.text('Next'));
          await tester.pumpAndSettle();

          expect(find.text('Save Favorites'), findsOneWidget);

          // Tap Get Started
          await tester.tap(find.text('Get Started'));
          await tester.pumpAndSettle();

          // Should be on home screen
          expect(find.text('Pet Finder'), findsOneWidget);

          // Wait for pets to load
          await tester.pumpAndSettle(const Duration(seconds: 3));

          // Should see pet cards
          expect(find.byType(GridView), findsOneWidget);

          // Tap on first pet card
          final petCard = find.byType(Card).first;
          await tester.tap(petCard);
          await tester.pumpAndSettle();

          // Should be on details screen
          expect(find.byIcon(Icons.favorite_border), findsWidgets);

          // Tap favorite button
          final favoriteButton = find.byIcon(Icons.favorite_border).first;
          await tester.tap(favoriteButton);
          await tester.pumpAndSettle();

          // Icon should change to filled favorite
          expect(find.byIcon(Icons.favorite), findsWidgets);

          // Go back to home
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          // Go to favorites screen
          await tester.tap(find.byIcon(Icons.favorite).first);
          await tester.pumpAndSettle();

          // Should see favorites screen with at least one pet
          expect(find.text('Favorites'), findsOneWidget);
          expect(find.byType(GridView), findsOneWidget);

          // Test search functionality
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          // Tap search icon
          await tester.tap(find.byIcon(Icons.search));
          await tester.pumpAndSettle();

          // Should see breed search bottom sheet
          expect(find.text('Search by Breed'), findsOneWidget);
        });

    testWidgets('Test adding and removing favorites', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Skip onboarding if present
      if (find.text('Skip').evaluate().isNotEmpty) {
        await tester.tap(find.text('Skip'));
        await tester.pumpAndSettle();
      }

      // Wait for home screen
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find favorite button on first pet card
      final favoriteButton = find.byIcon(Icons.favorite_border).first;
      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();

      // Navigate to favorites
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle();

      // Should see one favorite
      expect(find.byType(Card), findsWidgets);

      // Tap remove favorite
      final removeFavoriteButton = find.byIcon(Icons.favorite).first;
      await tester.tap(removeFavoriteButton);
      await tester.pumpAndSettle();

      // Should show empty state
      expect(find.text('No favorites yet'), findsOneWidget);
    });

    testWidgets('Test error handling', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Skip to home
      if (find.text('Skip').evaluate().isNotEmpty) {
        await tester.tap(find.text('Skip'));
        await tester.pumpAndSettle();
      }

      await tester.pumpAndSettle(const Duration(seconds: 3));

      // If there's an error, should see retry button
      if (find.text('Retry').evaluate().isNotEmpty) {
        expect(find.text('Retry'), findsOneWidget);
        await tester.tap(find.text('Retry'));
        await tester.pumpAndSettle();
      }
    });
  });
}