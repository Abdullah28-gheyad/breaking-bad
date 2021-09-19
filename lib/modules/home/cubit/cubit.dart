import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:breakingbad/models/charclass.dart';
import 'package:breakingbad/modules/home/cubit/states.dart';
import 'package:breakingbad/shared/network/endpoints.dart';
import 'package:breakingbad/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState()) ;
  static AppCubit get(context)=>BlocProvider.of(context) ;
  List<Character> characters =[];
  List<Character> searchCharacters =[];
  void getAllChar()
  {
      emit(GetAllCharLoadingState()) ;
      DioHelper.getData(endPoint: CHARACTERS)
      .then((value){
         // print (value.data.toString()) ;
        for (int i  = 0 ; i <value.data.length;i++)
          {
           characters.add(Character.fromJson(value.data[i])) ;
          }
        emit(GetAllCharSuccessState()) ;
      })
      .catchError((error){
        print (error.toString()) ;
        emit(GetAllCharErrorState()) ;
      }) ;
  }

  void changeState()
  {
    emit(ChangeSetState()) ;
  }

  void searchChar(String s)
  {
    searchCharacters= [] ;
    String name;
    if (s.isNotEmpty)
      {
        for (int i = 0 ;  i <characters.length ; i++)
        {
          name = characters[i].name.toLowerCase() ;
          s = s.toLowerCase() ;
          if (name.contains(s))
          {
            searchCharacters.add(characters[i]) ;
          }

        }
      }
   else {
      searchCharacters=[] ;
    }
    emit(GetSearchAllCharSuccessState()) ;
  }
}