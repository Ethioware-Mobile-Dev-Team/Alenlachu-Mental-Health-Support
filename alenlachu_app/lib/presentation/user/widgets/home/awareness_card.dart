import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:flutter/material.dart';

class AwarenessCard extends StatefulWidget {
  final AwarenessModel awareness;
  const AwarenessCard({super.key, required this.awareness});

  @override
  State<AwarenessCard> createState() => _AwarenessCardState();
}

class _AwarenessCardState extends State<AwarenessCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 240,
          width: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 200, 200, 200),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: widget.awareness.image == null
                            ? const AssetImage(
                                'assets/images/awarness_default.png')
                            : NetworkImage(widget.awareness.image!),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.awareness.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.awareness.createdDate.toString(),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
