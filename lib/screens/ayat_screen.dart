import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/cubit/global_cubit.dart';
import 'package:quraan/cubit/global_state.dart';
import 'package:quraan/helpers/cache_helper.dart';
import 'package:quraan/models/quraan_model/quraan_model.dart';

class AyatScreen extends StatelessWidget {
  const AyatScreen({super.key, required this.soraModel});
  final SoraModel soraModel;

  @override
  Widget build(BuildContext context) {
    final CacheHelper cacheHelper = CacheHelper();
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: List.generate(
                  soraModel.ayat!.length,
                  (index) => GestureDetector(
                    onLongPress: () {
                      context.read<GlobalCubit>().updateCachedSoraAndAya(
                            sora: soraModel.soraName!,
                            aya: soraModel.ayat![index].arabic!,
                          );
                    },
                    child: Card(
                      key: soraModel.ayat![index].arabic ==
                              cacheHelper.getCachedAya()
                          ? context.read<GlobalCubit>().ayaKey
                          : null,
                      margin: const EdgeInsets.only(top: 32),
                      child: BlocBuilder<GlobalCubit, GlobalState>(
                        builder: (context, state) {
                          return Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${soraModel.ayat![index].arabic}",
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: soraModel.ayat![index].arabic ==
                                        cacheHelper.getCachedAya()
                                    ? Colors.red
                                    : null,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 150))
          ]),
          floatingActionButton: FloatingActionButton.large(
            child: const Icon(Icons.remove_red_eye),
            onPressed: () {
              if (context.read<GlobalCubit>().ayaKey.currentContext != null) {
                Scrollable.ensureVisible(
                  context.read<GlobalCubit>().ayaKey.currentContext!,
                );
              }
            },
          ),
        );
      },
    );
  }
}
