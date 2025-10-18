part of 'pet_cubit.dart';

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object> get props => [];
}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<PetModel> pets;

  const PetLoaded(this.pets);

  @override
  List<Object> get props => [pets];
}

class BreedLoading extends PetState {}

class BreedLoaded extends PetState {
  final List<BreedModel> breeds;

  const BreedLoaded(this.breeds);

  @override
  List<Object> get props => [breeds];
}

class PetError extends PetState {
  final String message;

  const PetError(this.message);

  @override
  List<Object> get props => [message];
}