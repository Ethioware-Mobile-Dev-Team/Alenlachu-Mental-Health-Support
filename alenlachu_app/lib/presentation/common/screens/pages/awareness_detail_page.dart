import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';

import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AwarenessDetailPage extends StatefulWidget {
  final AwarenessModel awareness;

  const AwarenessDetailPage({super.key, required this.awareness});

  @override
  State<AwarenessDetailPage> createState() => _AwarenessDetailPageState();
}

class _AwarenessDetailPageState extends State<AwarenessDetailPage> {
  String formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      spreadRadius: 2)
                ],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            image: DecorationImage(
                                image: widget.awareness.image == null
                                    ? const AssetImage(
                                        'assets/images/awarness_default.png',
                                      )
                                    : NetworkImage(widget.awareness.image!),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 30,
                        child: GestureDetector(
                          onTap: null,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Center(
                              child: Icon(Icons.bookmark),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          lable: widget.awareness.title,
                          size: 24,
                          color: Colors.black,
                        ),
                        Row(
                          //
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                StyledText(
                                  lable: "Posted:",
                                  size: 16,
                                  isBold: false,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            StyledText(
                              lable: formatDate(widget.awareness.createdDate),
                              size: 16,
                              isBold: false,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      spreadRadius: 2)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StyledText(
                    lable: 'Description',
                    color: Colors.black,
                    size: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StyledText(
                    lable: widget.awareness.description,
                    color: const Color.fromARGB(255, 58, 58, 58),
                    size: 15,
                    isBold: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
