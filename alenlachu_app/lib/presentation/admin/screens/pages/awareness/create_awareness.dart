import 'package:alenlachu_app/blocs/common/awareness/awareness_bloc.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_event.dart';
import 'package:alenlachu_app/blocs/common/awareness/awareness_state.dart';
import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:alenlachu_app/data/common/services/helper/unique_id.dart';
import 'package:alenlachu_app/presentation/admin/widgets/admin_app_bar.dart';
import 'package:alenlachu_app/presentation/common/widgets/main_button.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
            child: ListView(
              children: [
                _buildTextField(
                    _titleController, 'Title', 50, 'Please enter a title'),
                const SizedBox(height: 10),
                _buildTextField(_descriptionController, 'Description', 100,
                    'Please enter a description'),
                const SizedBox(height: 50),
                BlocBuilder<AwarenessBloc, AwarenessState>(
                  builder: (_, state) {
                    return MainButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _createAwareness(context);
                        }
                      },
                      child: state is AwarenessLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const StyledText(lable: 'Create Awareness'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      double height, String validationMessage) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 226, 226, 226),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }

  void _createAwareness(BuildContext context) {
    AwarenessModel awareness = AwarenessModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      createdDate: DateTime.now(),
    );
    BlocProvider.of<AwarenessBloc>(context).add(CreateAwareness(awareness));
  }
}
