// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:test_coda/common/box_keys.dart';
import 'package:test_coda/common/constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<AttemptLogin>(_attemptLogin);
  }

  FutureOr<void> _attemptLogin(
    AttemptLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(status: LoginStateStatus.attemptingLogin),
    );
    try {
      final uri = Uri.https(Constants.authority, '/mia-auth/login');

      final response = await http.post(
        uri,
        body: {
          'email': event.username,
          'password': event.password,
        },
      );
      final decodedResponse = jsonDecode(response.body);

      if (decodedResponse['success'] != true) {
        return emit(
          state.copyWith(
            error: Exception(),
            status: LoginStateStatus.badCredentials,
          ),
        );
      }

      final token = decodedResponse['response']['access_token'];

      await Hive.box<dynamic>(BoxKeys.token).put(
        'token',
        token,
      );

      emit(
        state.copyWith(
          status: LoginStateStatus.succesful,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: Exception(e),
          status: LoginStateStatus.failure,
        ),
      );
    }
  }

  void attemptLogin(String username, String password) {
    add(AttemptLogin(username: username, password: password));
  }
}
