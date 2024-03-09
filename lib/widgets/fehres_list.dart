import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/cubit/global_cubit.dart';
import 'package:quraan/cubit/global_state.dart';
import 'package:quraan/font_size/font_size.dart';
import 'package:quraan/helpers/cache_helper.dart';
import 'package:quraan/helpers/service_locator.dart';

class FehresList extends StatelessWidget {
  const FehresList({super.key});

  @override
  Widget build(BuildContext context) {
    final CacheHelper cacheHelper = sl<CacheHelper>();
    context.read<GlobalCubit>().scrollSoraKeyInFehres(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Column(
          children: List.generate(
            context.read<GlobalCubit>().listData.length,
            (index) => GestureDetector(
              onTap: () {
                context.read<GlobalCubit>().updateSelectedSora(
                    context.read<GlobalCubit>().listData[index].soraName!);
                Navigator.pop(context);
                context.read<GlobalCubit>().scrollSoraKey(context);
              },
              child: Card(
                margin: const EdgeInsets.only(top: 32),
                key: context.read<GlobalCubit>().listData[index].soraName ==
                        context.read<GlobalCubit>().selectedSora
                    ? context.read<GlobalCubit>().soraKeyInFehrs
                    : null,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: context
                                      .read<GlobalCubit>()
                                      .listData[index]
                                      .soraName ==
                                  cacheHelper.getCachedSora()
                              ? Colors.red
                              : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${context.read<GlobalCubit>().listData[index].soraName}",
                        style: TextStyle(
                          fontSize: kFontSize,
                          fontWeight: FontWeight.bold,
                          color: context
                                      .read<GlobalCubit>()
                                      .listData[index]
                                      .soraName ==
                                  cacheHelper.getCachedSora()
                              ? Colors.red
                              : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
