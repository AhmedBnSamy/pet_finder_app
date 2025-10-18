import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/app_router.dart';
import '../cubit/pet_cubit/pet_cubit.dart';
import '../widgets/pet_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PetCubit>().fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Finder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              context.push(AppRouter.favorites);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchBottomSheet();
            },
          ),
        ],
      ),
      body: BlocBuilder<PetCubit, PetState>(
        builder: (context, state) {
          if (state is PetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PetError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PetCubit>().fetchPets();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is PetLoaded) {
            if (state.pets.isEmpty) {
              return const Center(child: Text('No pets found'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.pets.length,
              itemBuilder: (context, index) {
                final pet = state.pets[index];
                return PetCard(
                  pet: pet,
                  onTap: () {
                    context.push(AppRouter.details, extra: pet);
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: context.read<PetCubit>(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Search by Breed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<PetCubit, PetState>(
                  builder: (context, state) {
                    if (state is BreedLoaded) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.breeds.length,
                          itemBuilder: (context, index) {
                            final breed = state.breeds[index];
                            return ListTile(
                              title: Text(breed.name),
                              subtitle: Text(breed.origin ?? ''),
                              onTap: () {
                                Navigator.pop(context);
                                context
                                    .read<PetCubit>()
                                    .searchPetsByBreed(breed.id);
                              },
                            );
                          },
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        context.read<PetCubit>().fetchBreeds();
                      },
                      child: const Text('Load Breeds'),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}