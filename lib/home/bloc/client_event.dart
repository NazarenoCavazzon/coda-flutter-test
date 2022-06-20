part of 'client_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadClients extends HomeEvent {}

class LoadMoreClients extends HomeEvent {}

class EditClient extends HomeEvent {
  const EditClient({
    required this.client,
  });
  final Client client;

  @override
  List<Object> get props => [client];
}

class CreateClient extends HomeEvent {
  const CreateClient({
    required this.client,
  });
  final Client client;

  @override
  List<Object> get props => [client];
}

class InitialClient extends HomeEvent {}

class DeleteClient extends HomeEvent {
  const DeleteClient({
    required this.client,
  });
  final Client client;

  @override
  List<Object> get props => [client];
}
