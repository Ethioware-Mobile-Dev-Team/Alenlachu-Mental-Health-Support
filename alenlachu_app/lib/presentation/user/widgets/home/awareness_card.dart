import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:alenlachu_app/presentation/common/screens/pages/awareness_detail_page.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AwarenessCard extends StatefulWidget {
  final AwarenessModel awareness;
  const AwarenessCard({super.key, required this.awareness});

  @override
  State<AwarenessCard> createState() => _AwarenessCardState();
}

class _AwarenessCardState extends State<AwarenessCard> {
  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AwarenessDetailPage(awareness: widget.awareness)));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
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
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledText(
                        lable: widget.awareness.title,
                        color: Colors.black,
                      ),
                      StyledText(
                        lable: widget.awareness.description,
                        color: Colors.grey,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        size: 14,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      StyledText(
                        lable: 'Read More',
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
