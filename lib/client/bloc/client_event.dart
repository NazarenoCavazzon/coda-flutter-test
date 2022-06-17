part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class LoadClients extends ClientEvent {}

class LoadMoreClients extends ClientEvent {}

class EditClient extends ClientEvent {}

class CreateClient extends ClientEvent {}

class DeleteClient extends ClientEvent {}
