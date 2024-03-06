import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/app/quraan.dart';
import 'package:quraan/cubit/global_cubit.dart';
import 'package:quraan/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await CacheHelper().init();
  runApp(
    BlocProvider(
      create: (context) => GlobalCubit()..getQuraanList(),
      child: const Quraan(),
    ),
  );
}
