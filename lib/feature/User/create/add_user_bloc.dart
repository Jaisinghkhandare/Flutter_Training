import 'package:exercise01/feature/core/state/ui_state.dart';
import 'package:exercise01/feature/User/create/add_user_event.dart';
import 'package:exercise01/feature/core/service/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_model.dart';

class AddUserBloc extends Bloc<AddUseEvent,UiState<User>>{
  final ApiService apiService;
  AddUserBloc(this.apiService):super(Initial()){
    on<AddUseEvent>((event, emit) async {
      emit(Loading());
      try {
        User user = await apiService.createUser(event.user);
        emit(Success(user));
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }
}

