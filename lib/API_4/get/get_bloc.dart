import 'dart:async';
import 'package:apl/API_4/Home.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'get_event.dart';
import 'get_state.dart';

class GetBloc extends Bloc< GetEvent ,GetState> {
  GetBloc() : super(GetIntial()) {
    on<GetData>(_getdata);
  }
  Map list = {};
  _getdata(GetData event, Emitter<GetState> emit) async {
    try {
      emit(GetLoading());
      final dio = Dio();
      var response =  await dio.get('https://dummyjson.com/products');
      list=(response.data);
      print("data : $list");
      Get.off(Home3());
      emit(GetLoaded());

    } catch (e) {
      emit(GetError());
    }
  }

}
