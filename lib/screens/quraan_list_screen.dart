import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quraan/cubit/global_cubit.dart';
import 'package:quraan/cubit/global_state.dart';
import 'package:quraan/widgets/doaa_elkhatma.dart';
import 'package:quraan/widgets/fehres_list.dart';

class QuraanListScreen extends StatelessWidget {
  const QuraanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GlobalCubit>().scrollSoraKeyInFehres(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          body: const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    FehresList(),
                    DoaaElkhatma(),
                    SizedBox(height: 120),
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.large(
            child: const Icon(Icons.remove_red_eye),
            onPressed: () {
              context.read<GlobalCubit>().scrollSoraKeyInFehres(context);
            },
          ),
        );
      },
    );
  }
}
