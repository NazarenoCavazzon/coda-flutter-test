part of 'client_bloc.dart';

enum ClientStateStatus {
  initial,
  loadingClients,
  loadingMoreClients,
  creatingClient,
  editingClient,
  deletingClient,
  succesful,
  failure,
}

class ClientState extends Equatable {
  const ClientState({
    this.error,
    this.status = ClientStateStatus.initial,
    this.clients = const [],
    this.isLastPage = false,
    this.pageIndex = 1,
  });
  final ClientStateStatus status;
  final Exception? error;
  final List<Client> clients;
  final bool isLastPage;
  final int pageIndex;

  ClientState copyWith({
    Exception? error,
    ClientStateStatus? status,
    List<Client>? clients,
    bool? isLastPage,
    int? pageIndex,
  }) {
    return ClientState(
      error: error ?? this.error,
      status: status ?? this.status,
      clients: clients ?? this.clients,
      isLastPage: isLastPage ?? this.isLastPage,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  bool get isInitial => status == ClientStateStatus.initial;
  bool get isLoadingClients => status == ClientStateStatus.loadingClients;
  bool get isLoadingMoreClients =>
      status == ClientStateStatus.loadingMoreClients;
  bool get isCreatingClient => status == ClientStateStatus.creatingClient;
  bool get isEditingClient => status == ClientStateStatus.editingClient;
  bool get isDeletingClient => status == ClientStateStatus.deletingClient;
  bool get isSuccesful => status == ClientStateStatus.succesful;
  bool get isFailure => status == ClientStateStatus.failure;

  @override
  List<Object?> get props => [
        error ?? Object(),
        status,
        clients,
        isLastPage,
        pageIndex,
      ];
}
