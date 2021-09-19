import 'package:breakingbad/blocobserver.dart';
import 'package:breakingbad/modules/home/cubit/cubit.dart';
import 'package:breakingbad/modules/home/home.dart';
import 'package:breakingbad/shared/network/remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized() ;
  Bloc.observer = MyBlocObserver();
  DioHelper.init() ;
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..getAllChar(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
