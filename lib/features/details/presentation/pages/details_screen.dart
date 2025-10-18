import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../home/data/models/pet_model.dart';
import '../../../home/presentation/cubit/favorites_cubit/favorites_cubit.dart';

class DetailsScreen extends StatelessWidget {
  final PetModel pet;

  const DetailsScreen({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    final breed = pet.breeds?.isNotEmpty == true ? pet.breeds!.first : null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: pet.id,
                child: CachedNetworkImage(
                  imageUrl: pet.url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, size: 50),
                  ),
                ),
              ),
            ),
            actions: [
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final isFavorite = state is FavoritesLoaded &&
                      state.favorites.any((p) => p.id == pet.id);

                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        context.read<FavoritesCubit>().removeFavorite(pet.id);
                      } else {
                        context.read<FavoritesCubit>().addFavorite(pet);
                      }
                    },
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (breed != null) ...[
                    Text(
                      breed.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (breed.origin != null)
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            breed.origin!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    if (breed.description != null) ...[
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        breed.description!,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (breed.temperament != null) ...[
                      const Text(
                        'Temperament',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: breed.temperament!
                            .split(',')
                            .map((trait) => Chip(
                          label: Text(trait.trim()),
                          backgroundColor: Colors.blue[50],
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
                    const Text(
                      'Characteristics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (breed.lifeSpan != null)
                      _buildCharacteristic(
                        'Life Span',
                        '${breed.lifeSpan} years',
                        Icons.calendar_today,
                      ),
                    if (breed.affectionLevel != null)
                      _buildRatingCharacteristic(
                        'Affection Level',
                        breed.affectionLevel!,
                        Icons.favorite,
                      ),
                    if (breed.childFriendly != null)
                      _buildRatingCharacteristic(
                        'Child Friendly',
                        breed.childFriendly!,
                        Icons.child_care,
                      ),
                    if (breed.dogFriendly != null)
                      _buildRatingCharacteristic(
                        'Dog Friendly',
                        breed.dogFriendly!,
                        Icons.pets,
                      ),
                    if (breed.energyLevel != null)
                      _buildRatingCharacteristic(
                        'Energy Level',
                        breed.energyLevel!,
                        Icons.bolt,
                      ),
                    if (breed.adaptability != null)
                      _buildRatingCharacteristic(
                        'Adaptability',
                        breed.adaptability!,
                        Icons.settings,
                      ),
                  ] else ...[
                    const Center(
                      child: Text(
                        'No breed information available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacteristic(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            '$title: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingCharacteristic(String title, int rating, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: List.generate(
              5,
                  (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                size: 18,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}