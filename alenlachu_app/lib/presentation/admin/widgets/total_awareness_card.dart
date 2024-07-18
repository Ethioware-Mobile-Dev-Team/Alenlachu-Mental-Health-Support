
import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AwarenessCountCard extends StatelessWidget {
  const AwarenessCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: BlocBuilder<AwarenessBloc, AwarenessState>(
          builder: (context, state) {
            if (state is AwarenessLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AwarenessLoaded) {
              return CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                child: Text(
                  '${state.awarenesss.length}+\nLessons',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              );
            } else {
              return const Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }
}
