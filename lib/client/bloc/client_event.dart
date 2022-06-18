part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class LoadClients extends ClientEvent {}

class LoadMoreClients extends ClientEvent {}

class EditClient extends ClientEvent {
  const EditClient({
    required this.client,
  });
  final Client client;

  @override
  List<Object> get props => [client];
}

class CreateClient extends ClientEvent {
  const CreateClient({
    required this.client,
  });
  final Client client;

  @override
  List<Object> get props => [client];
}

class InitialClient extends ClientEvent {}

class DeleteClient extends ClientEvent {
  const DeleteClient({
    required this.client,
  });
  final Client client;

  @override
  List<Object> get props => [client];
}
