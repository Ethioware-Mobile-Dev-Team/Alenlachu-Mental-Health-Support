import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';

class AdminAwarenessCard extends StatefulWidget {
  final AwarenessModel awareness;

  const AdminAwarenessCard({super.key, required this.awareness});

  @override
  _AdminAwarenessCardState createState() => _AdminAwarenessCardState();
}

class _AdminAwarenessCardState extends State<AdminAwarenessCard> {
  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 200,
          width: MediaQuery.of(context).size.width,
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
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: widget.awareness.image == null
                            ? const AssetImage(
                                'assets/images/awarness_default.png')
                            : NetworkImage(widget.awareness.image!)
                                as ImageProvider,
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
                      _formatDate(widget.awareness.createdDate),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
