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

enum ClientCudStatus {
  initial,
  createdSuccessfully,
  updatedSuccessfully,
  deletedSuccessfully,
  failure,
}

class HomeState extends Equatable {
  const HomeState({
    this.error,
    this.status = ClientStateStatus.initial,
    this.clients = const [],
    this.isLastPage = false,
    this.pageIndex = 1,
    this.cudStatus = ClientCudStatus.initial,
  });
  final ClientStateStatus status;
  final Exception? error;
  final List<Client> clients;
  final bool isLastPage;
  final int pageIndex;
  final ClientCudStatus cudStatus;

  HomeState copyWith({
    Exception? error,
    ClientStateStatus? status,
    List<Client>? clients,
    bool? isLastPage,
    int? pageIndex,
    ClientCudStatus? cudStatus,
  }) {
    return HomeState(
      error: error ?? this.error,
      status: status ?? this.status,
      clients: clients ?? this.clients,
      isLastPage: isLastPage ?? this.isLastPage,
      pageIndex: pageIndex ?? this.pageIndex,
      cudStatus: cudStatus ?? this.cudStatus,
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
        cudStatus,
      ];
}
