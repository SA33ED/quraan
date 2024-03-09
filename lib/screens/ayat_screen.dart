import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/cubit/global_cubit.dart';
import 'package:quraan/cubit/global_state.dart';
import 'package:quraan/font_size/font_size.dart';
import 'package:quraan/helpers/cache_helper.dart';
import 'package:quraan/helpers/service_locator.dart';
import 'package:quraan/models/quraan_model/quraan_model.dart';
import 'package:quraan/widgets/doaa_elkhatma.dart';
import 'package:quraan/widgets/fehres_list.dart';

class AyatScreen extends StatelessWidget {
  const AyatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GlobalCubit>();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
    cubit.scrollSoraKey(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: const Drawer(
            backgroundColor: Colors.black,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        FehresList(),
                        DoaaElkhatma(),
                        Ad3ya(),
                        SizedBox(height: 120),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(
                cubit.listData.length,
                (index) => Surah(
                  soraModel: cubit.listData[index],
                  selectedSora: cubit.selectedSora,
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.large(
            child: const Icon(Icons.remove_red_eye),
            onPressed: () {
              cubit.scrollAyaKey(context);
              // context
              //     .read<GlobalCubit>()
              //     .updateCachedSoraAndAya(sora: "البقره", aya: "الم", index: 0);
            },
          ),
        );
      },
    );
  }
}

class Surah extends StatelessWidget {
  const Surah({super.key, required this.soraModel, required this.selectedSora});
  final SoraModel soraModel;
  final String selectedSora;

  @override
  Widget build(BuildContext context) {
    final CacheHelper cacheHelper = sl<CacheHelper>();
    // context.read<GlobalCubit>().scrollAyaKey(context);
    return Column(
      children: [
        SurahNameCard(
            soraModel: soraModel,
            cacheHelper: cacheHelper,
            selectedSora: selectedSora),
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: List.generate(
              soraModel.ayat!.length,
              (ayaIndex) => InkWell(
                onLongPress: () {
                  context.read<GlobalCubit>().updateCachedSoraAndAya(
                      sora: soraModel.soraName!,
                      aya: soraModel.ayat![ayaIndex].arabic!,
                      index: ayaIndex);
                },
                child: AyaCard(
                    surahModel: soraModel,
                    ayaIndex: ayaIndex,
                    cacheHelper: cacheHelper),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SurahNameCard extends StatelessWidget {
  const SurahNameCard({
    super.key,
    required this.soraModel,
    required this.cacheHelper,
    required this.selectedSora,
  });

  final SoraModel soraModel;
  final CacheHelper cacheHelper;
  final String selectedSora;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: soraModel.soraName == selectedSora
          ? context.read<GlobalCubit>().soraKey
          : null,
      margin: const EdgeInsets.only(top: 32),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          soraModel.soraName!,
          style: TextStyle(
            fontSize: kFontSize,
            fontWeight: FontWeight.bold,
            color: soraModel.soraName == cacheHelper.getCachedSora()
                ? Colors.red
                : Colors.yellow,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AyaCard extends StatelessWidget {
  const AyaCard(
      {super.key,
      required this.ayaIndex,
      required this.cacheHelper,
      required this.surahModel});
  final int ayaIndex;
  final CacheHelper cacheHelper;
  final SoraModel surahModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      key:
          "${surahModel.soraName}${surahModel.ayat![ayaIndex].arabic}$ayaIndex" ==
                  cacheHelper.getCachedAya()
              ? context.read<GlobalCubit>().ayaKey
              : null,
      margin: const EdgeInsets.only(top: 28),
      child: Container(
          alignment: Alignment.topRight,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${surahModel.ayat![ayaIndex].arabic}",
                  style: TextStyle(
                    fontSize: kFontSize,
                    fontWeight: FontWeight.bold,
                    color:
                        "${surahModel.soraName}${surahModel.ayat![ayaIndex].arabic}$ayaIndex" ==
                                cacheHelper.getCachedAya()
                            ? Colors.red
                            : null,
                  ),
                ),
                TextSpan(
                  text: ayaIndex == 0 ? "" : " - $ayaIndex",
                  style: TextStyle(
                    fontSize: kFontSize,
                    fontWeight: FontWeight.bold,
                    color:
                        "${surahModel.soraName}${surahModel.ayat![ayaIndex].arabic}$ayaIndex" ==
                                cacheHelper.getCachedAya()
                            ? Colors.red
                            : null,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.right,
          )
          //  Text(
          //   "${ayaIndex + 1} - ${surahModel.ayat![ayaIndex].arabic}",
          //   style: TextStyle(
          //     fontSize: 100,
          //     fontWeight: FontWeight.bold,
          //     color:
          //         "${surahModel.soraName}${surahModel.ayat![ayaIndex].arabic}$ayaIndex" ==
          //                 cacheHelper.getCachedAya()
          //             ? Colors.red
          //             : null,
          //   ),
          //   textAlign: TextAlign.right,
          // ),
          ),
    );
  }
}
