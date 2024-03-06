import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/cubit/global_cubit.dart';
import 'package:quraan/cubit/global_state.dart';
import 'package:quraan/helpers/cache_helper.dart';
import 'package:quraan/screens/ayat_screen.dart';

class FehresList extends StatelessWidget {
  const FehresList({super.key});

  @override
  Widget build(BuildContext context) {
    final CacheHelper cacheHelper = CacheHelper();
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Column(
          children: List.generate(
            context.read<GlobalCubit>().listData.length,
            (index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AyatScreen(
                      soraModel: context.read<GlobalCubit>().listData[index],
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(top: 32),
                key: context.read<GlobalCubit>().listData[index].soraName ==
                        cacheHelper.getCachedSora()
                    ? context.read<GlobalCubit>().soraKey
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
                          fontSize: 100,
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
