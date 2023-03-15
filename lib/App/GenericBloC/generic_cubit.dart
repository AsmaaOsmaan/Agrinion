import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'generic_state.dart';

class GenericCubit<T> extends Cubit<GenericState<T>> {
  GenericCubit(T data) : super(GenericInitialState<T>(data));

  onUpdateData(T data){
    emit(GenericUpdateState<T>(data, !state.changed));
  }

}