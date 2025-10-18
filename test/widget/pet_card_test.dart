import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_finder_app/features/home/data/models/pet_model.dart';
import 'package:pet_finder_app/features/home/presentation/widgets/pet_card.dart';


void main() {
  group('PetCard Widget Tests', () {
    const testPet = PetModel(
      id: 'test_1',
      url: 'https://example.com/cat.jpg',
      width: 500,
      height: 500,
      breeds: const [
        BreedModel(
          id: 'abys',
          name: 'Abyssinian',
          temperament: 'Active',
          origin: 'Egypt',
        ),
      ],
    );

    testWidgets('should display pet image', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PetCard(
              pet: testPet,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display breed name if available', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PetCard(
              pet: testPet,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Abyssinian'), findsOneWidget);
    });

    testWidgets('should call onTap when card is tapped', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PetCard(
              pet: testPet,
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PetCard));
      await tester.pump();

      expect(wasTapped, true);
    });

    testWidgets('should display favorite icon button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PetCard(
              pet: testPet,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });
  });
}