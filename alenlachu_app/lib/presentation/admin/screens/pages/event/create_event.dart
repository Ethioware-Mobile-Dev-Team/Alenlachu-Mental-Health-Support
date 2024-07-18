import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';
import 'package:alenlachu_app/data/common/models/event/orginizer_model.dart';
import 'package:alenlachu_app/presentation/admin/widgets/admin_app_bar.dart';
import 'package:alenlachu_app/presentation/common/widgets/main_button.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _organizerNameController =
      TextEditingController();
  final TextEditingController _organizerLocationController =
      TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _organizerNameController.dispose();
    _organizerLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventOperationSuccess) {
            showToast('Event posted successfully');
          } else if (state is EventOperationFailure) {
            showToast(state.error);
          } else if (state is EventLoading) {
            showToast('Event loading');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(
                    _titleController, 'Title', 50, 'Please enter the title'),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(_descriptionController, 'Description', 100,
                    'Please enter the description'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(context),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: _buildTimeField(context)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(_organizerNameController, 'Organizer Name', 50,
                    'Please enter the organizer Name'),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(_organizerLocationController, 'Location', 50,
                    'Please enter the organizer Location'),
                const SizedBox(height: 50),
                BlocBuilder<EventBloc, EventState>(
                  builder: (_, state) {
                    return MainButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _createEvent(context);
                        }
                      },
                      child: state is EventLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const StyledText(lable: 'Post Event'),
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

  Widget _buildDateField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 226, 226, 226),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        controller: _dateController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Date',
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              try {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1800),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  _dateController.text =
                      pickedDate.toIso8601String().split('T').first;
                }
              } catch (e) {
                showToast('Error: $e');
              }
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the date';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 226, 226, 226),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        controller: _timeController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Time',
          suffixIcon: IconButton(
            icon: const Icon(Icons.access_time),
            onPressed: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                _timeController.text = pickedTime.format(context);
              }
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the time';
          }
          return null;
        },
      ),
    );
  }

  void _createEvent(BuildContext context) {
    Organizer org = Organizer(
      name: _organizerNameController.text.trim(),
      location: _organizerLocationController.text.trim(),
    );
    EventModel event = EventModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      date: _dateController.text.trim(),
      time: _timeController.text,
      organizer: org,
      rsvps: const [],
    );
    BlocProvider.of<EventBloc>(context).add(CreateEvent(event));
  }
}
