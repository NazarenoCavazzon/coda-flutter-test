// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:test_coda/client/models/client.dart';
import 'package:test_coda/client/models/client_list_response.dart';
import 'package:test_coda/common/box_keys.dart';
import 'package:test_coda/common/constants.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc() : super(const ClientState()) {
    on<LoadClients>(_loadClients);
    on<CreateClient>(_createClient);
    on<EditClient>(_editClient);
    on<LoadMoreClients>(_loadMoreClients);
    on<InitialClient>(_initialClient);
  }

  FutureOr<void> _loadClients(
    LoadClients event,
    Emitter<ClientState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ClientStateStatus.loadingClients,
        pageIndex: 1,
      ),
    );
    try {
      final uri = Uri.https(Constants.authority, '/client/list', {
        'page': state.pageIndex.toString(),
      });
      final token = Hive.box<dynamic>(BoxKeys.token).get('token');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final decodedResponse = jsonDecode(response.body);

      if (decodedResponse['success'] != true) {
        return emit(
          state.copyWith(
            error: Exception(),
            status: ClientStateStatus.failure,
          ),
        );
      }

      final clientListResponse = ClientListResponse.fromMap(
        (decodedResponse['response'] as Map).cast<String, dynamic>(),
      );

      emit(
        state.copyWith(
          clients: clientListResponse.clients,
          status: ClientStateStatus.succesful,
          isLastPage: clientListResponse.lastPage == state.pageIndex,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: Exception(e),
          status: ClientStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _loadMoreClients(
    LoadMoreClients event,
    Emitter<ClientState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ClientStateStatus.loadingMoreClients,
        pageIndex: state.pageIndex + 1,
      ),
    );
    try {
      final uri = Uri.https(Constants.authority, '/client/list', {
        'page': state.pageIndex.toString(),
      });
      final token = Hive.box<dynamic>(BoxKeys.token).get('token');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final decodedResponse = jsonDecode(response.body);

      if (decodedResponse['success'] != true) {
        return emit(
          state.copyWith(
            error: Exception(),
            status: ClientStateStatus.failure,
          ),
        );
      }

      final clientListResponse = ClientListResponse.fromMap(
        (decodedResponse['response'] as Map).cast<String, dynamic>(),
      );
      final clients = state.clients + clientListResponse.clients;

      emit(
        state.copyWith(
          clients: clients,
          status: ClientStateStatus.succesful,
          isLastPage: clientListResponse.total == clients.length,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: Exception(e),
          status: ClientStateStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _initialClient(
    InitialClient event,
    Emitter<ClientState> emit,
  ) async {
    emit(
      state.copyWith(
        cudStatus: ClientCudStatus.initial,
      ),
    );
  }

  FutureOr<void> _createClient(
    CreateClient event,
    Emitter<ClientState> emit,
  ) async {
    emit(
      state.copyWith(
        cudStatus: ClientCudStatus.initial,
      ),
    );
    try {
      final uri = Uri.https(Constants.authority, '/client/save');
      final token = Hive.box<dynamic>(BoxKeys.token).get('token');
      final response = await http.post(
        uri,
        body: {
          'firstname': event.client.firstname,
          'lastname': event.client.lastname,
          'email': event.client.email,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final decodedResponse = jsonDecode(response.body);

      if (decodedResponse['success'] != true) {
        return emit(
          state.copyWith(
            error: Exception(),
            status: ClientStateStatus.failure,
          ),
        );
      }

      /// If this fails it's because some data is missing or broken and the try
      /// will catch the error.
      Client.fromMap(
        (decodedResponse['response'] as Map).cast<String, dynamic>(),
      );

      emit(
        state.copyWith(
          cudStatus: ClientCudStatus.createdSuccessfully,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: Exception(e),
          cudStatus: ClientCudStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _editClient(
    EditClient event,
    Emitter<ClientState> emit,
  ) async {
    emit(
      state.copyWith(
        cudStatus: ClientCudStatus.initial,
      ),
    );
    try {
      final uri = Uri.https(Constants.authority, '/client/save');
      final token = Hive.box<dynamic>(BoxKeys.token).get('token');
      final response = await http.post(
        uri,
        body: {
          'id': event.client.id.toString(),
          'firstname': event.client.firstname,
          'lastname': event.client.lastname,
          'email': event.client.email,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final decodedResponse = jsonDecode(response.body);

      if (decodedResponse['success'] != true) {
        return emit(
          state.copyWith(
            error: Exception(),
            status: ClientStateStatus.failure,
          ),
        );
      }

      /// If this fails it's because some data is missing or broken and the try
      /// will catch the error.
      Client.fromMap(
        (decodedResponse['response'] as Map).cast<String, dynamic>(),
      );

      emit(
        state.copyWith(
          cudStatus: ClientCudStatus.updatedSuccessfully,
        ),
      );

      add(
        LoadClients(),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: Exception(e),
          cudStatus: ClientCudStatus.failure,
        ),
      );
    }
  }

  void loadClients() {
    add(LoadClients());
  }

  void loadMoreClients() {
    add(LoadMoreClients());
  }

  void initialClient() {
    add(InitialClient());
  }

  void createClient(Client client) => add(
        CreateClient(client: client),
      );

  void editClient(Client client) => add(
        EditClient(client: client),
      );
}
