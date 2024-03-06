import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/cubit/global_cubit.dart';
import 'package:quraan/cubit/global_state.dart';
import 'package:quraan/screens/quraan_list_screen.dart';

class Quraan extends StatelessWidget {
  const Quraan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaler
            .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: scale),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          return const QuraanListScreen();
        },
      ),
      theme: ThemeData.dark(),
    );
  }
}
