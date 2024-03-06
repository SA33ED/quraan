import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/cubit/global_state.dart';
import 'package:flutter/services.dart';
import 'package:quraan/helpers/cache_helper.dart';
import 'dart:convert';

import 'package:quraan/models/quraan_model/quraan_model.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  List<SoraModel> listData = [];
  final soraKey = GlobalKey();
  final ayaKey = GlobalKey();
  getQuraanList() async {
    final data = await rootBundle.loadString("assets/the_quraan.json");
    final jsonData = json.decode(data) as List;
    for (int i = 0; i < jsonData.length; i++) {
      listData.add(
        SoraModel.fromJson(jsonData[i]),
      );
    }
    emit(GetQuraanList());
  }

  updateCachedSoraAndAya({
    required String sora,
    required String aya,
  }) {
    CacheHelper().cacheSoraAndAya(sora: sora, aya: aya);
    emit(UpdateSoraAndAya());
  }

  void scrollAyaKey(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final RenderObject? renderObject =
            ayaKey.currentContext?.findRenderObject();
        if (renderObject != null) {
          Scrollable.ensureVisible(ayaKey.currentContext!);
        }
      },
    );
  }

  void scrollSoraKey(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final RenderObject? renderObject =
            soraKey.currentContext?.findRenderObject();
        if (renderObject != null) {
          Scrollable.ensureVisible(soraKey.currentContext!);
        }
      },
    );
  }
}
