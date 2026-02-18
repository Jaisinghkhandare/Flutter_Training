import 'package:exercise01/UiState.dart';
import 'package:exercise01/feature/User/create/bloc/add_user_event.dart';
import 'package:exercise01/feature/User/list/api.dart';
import 'package:exercise01/model/UserModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserBloc extends Bloc<AddUseEvent,UiState<User>>{
  final ApiService apiService;
  //User user = new User(name: 'jais', email: 'jais@gmail.com', gender: 'Male', status: 'Active');
  AddUserBloc(this.apiService):super(Initial()){
    on<AddUseEvent>((event, emit)async {
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

