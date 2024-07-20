import 'dart:typed_data';
import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/presentation/common/screens/pages/awareness_detail_page.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAwarenessCard extends StatefulWidget {
  final AwarenessModel awareness;

  const AdminAwarenessCard({super.key, required this.awareness});

  @override
  _AdminAwarenessCardState createState() => _AdminAwarenessCardState();
}

class _AdminAwarenessCardState extends State<AdminAwarenessCard> {
  final ImagePicker _picker = ImagePicker();

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      // ignore: use_build_context_synchronously
      BlocProvider.of<AwarenessBloc>(context).add(UpdateAwarenessImage(
          awareness: widget.awareness, imageBytes: imageBytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AwarenessDetailPage(awareness: widget.awareness)));
          },
          child: Container(
            height: 100,
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
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width * 0.35,
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
                      const Positioned(
                          left: 10,
                          bottom: 10,
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 25,
                                color: Colors.black,
                              ),
                              StyledText(
                                lable: 'Update',
                                color: Colors.black,
                                isBold: false,
                              )
                            ],
                          ))
                    ],
                  ),
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
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
