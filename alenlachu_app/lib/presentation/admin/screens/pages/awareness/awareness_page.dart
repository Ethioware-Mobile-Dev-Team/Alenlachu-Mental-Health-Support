import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_state.dart';
import 'package:alenlachu_app/presentation/admin/widgets/admin_awareness_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AwarenessPage extends StatefulWidget {
  const AwarenessPage({super.key});

  @override
  State<AwarenessPage> createState() => _AwarenessPageState();
}

class _AwarenessPageState extends State<AwarenessPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BlocBuilder<AwarenessBloc, AwarenessState>(
            builder: (context, state) {
              if (state is AwarenessLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AwarenessLoaded) {
                if (state.awarenesss.isEmpty) {
                  return const Center(
                    child: Text('No Data found'),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 4.0, // Spacing between rows
                    crossAxisSpacing: 4.0, // Spacing between columns
                    childAspectRatio:
                        1.0, // Aspect ratio of each item (adjust as needed)
                  ),
                  itemCount: state.awarenesss.length,
                  itemBuilder: (context, index) {
                    final awareness = state.awarenesss[index];
                    return AdminAwarenessCard(awareness: awareness);
                  },
                );
              } else if (state is AwarenessOperationFailure) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(
                  child: Text('Unknown error occurred'),
                );
              }
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/createAwarenessPage');
            },
            backgroundColor: Theme.of(context).primaryColor,
            shape: const CircleBorder(),
            tooltip: 'Create Awareness',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
