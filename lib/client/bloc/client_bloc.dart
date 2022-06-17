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
  }

  FutureOr<void> _loadClients(
    LoadClients event,
    Emitter<ClientState> emit,
  ) async {
    emit(
      state.copyWith(status: ClientStateStatus.loadingClients),
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

  void loadClients() {
    add(LoadClients());
  }
}
