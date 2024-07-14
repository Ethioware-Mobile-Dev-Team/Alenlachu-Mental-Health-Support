import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_state.dart';
import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:alenlachu_app/data/common/services/helper/unique_id.dart';
import 'package:alenlachu_app/presentation/admin/widgets/admin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';

class AwarenessCreatePage extends StatefulWidget {
  const AwarenessCreatePage({super.key});

  @override
  _AwarenessCreatePageState createState() => _AwarenessCreatePageState();
}

class _AwarenessCreatePageState extends State<AwarenessCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      body: BlocListener<AwarenessBloc, AwarenessState>(
        listener: (context, state) {
          if (state is AwarenessOperationSuccess) {
            showToast("Awareness created successfully");
          } else if (state is AwarenessOperationFailure) {
            showToast("Failed to create awareness: ${state.error}");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String id = generateUUID();
                      AwarenessModel awareness = AwarenessModel(
                        id: id,
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        createdDate: DateTime.now(),
                      );
                      try {
                        BlocProvider.of<AwarenessBloc>(context)
                            .add(CreateAwareness(awareness));
                      } catch (e) {
                        showToast(e.toString());
                      }
                    }
                  },
                  child: const Text('Create Awareness'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
