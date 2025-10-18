import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet_model.g.dart';

@JsonSerializable()
class PetModel extends Equatable {
  final String id;
  final String url;
  final int? width;
  final int? height;
  final List<BreedModel>? breeds;

  const PetModel({
    required this.id,
    required this.url,
    this.width,
    this.height,
    this.breeds,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetModelToJson(this);

  @override
  List<Object?> get props => [id, url, width, height, breeds];
}

@JsonSerializable()
class BreedModel extends Equatable {
  final String id;
  final String name;
  final String? temperament;
  final String? origin;
  final String? description;
  @JsonKey(name: 'life_span')
  final String? lifeSpan;
  final int? adaptability;
  @JsonKey(name: 'affection_level')
  final int? affectionLevel;
  @JsonKey(name: 'child_friendly')
  final int? childFriendly;
  @JsonKey(name: 'dog_friendly')
  final int? dogFriendly;
  @JsonKey(name: 'energy_level')
  final int? energyLevel;
  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;

  const BreedModel({
    required this.id,
    required this.name,
    this.temperament,
    this.origin,
    this.description,
    this.lifeSpan,
    this.adaptability,
    this.affectionLevel,
    this.childFriendly,
    this.dogFriendly,
    this.energyLevel,
    this.wikipediaUrl,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) =>
      _$BreedModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    temperament,
    origin,
    description,
    lifeSpan,
    adaptability,
    affectionLevel,
    childFriendly,
    dogFriendly,
    energyLevel,
    wikipediaUrl,
  ];
}