import 'package:alenlachu_app/blocs/common/events/events_bloc.dart';
import 'package:alenlachu_app/blocs/common/events/events_event.dart';
import 'package:alenlachu_app/blocs/common/events/events_state.dart';
import 'package:alenlachu_app/data/common/models/event/event_model.dart';
import 'package:alenlachu_app/data/common/models/event/orginizer_model.dart';
import 'package:alenlachu_app/data/common/services/helper/unique_id.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPostPage extends StatefulWidget {
  const AdminPostPage({super.key});

  @override
  State<AdminPostPage> createState() => _AdminPostPageState();
}

class _AdminPostPageState extends State<AdminPostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _organizerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventInitial) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Event Initial"),
                duration: Duration(seconds: 1),
              ),
            );
          }

          if (state is EventOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Event posted successfully"),
                duration: Duration(seconds: 1),
              ),
            );
          }

          if (state is EventOperationFailure) {
            debugPrint(
                "############################################ ${state.error}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to post event: ${state.error}"),
                duration: const Duration(seconds: 10),
              ),
            );
          }

          if (state is EventLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Event loading"),
                duration: const Duration(seconds: 1),
              ),
            );
          }

          if (state is EventLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Event loading ${state.events}"),
                duration: const Duration(seconds: 10),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          _dateController.text =
                              pickedDate.toIso8601String().split('T').first;
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
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
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
                TextFormField(
                  controller: _organizerController,
                  decoration: const InputDecoration(
                    labelText: 'Organizer',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the organizer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<EventBloc, EventState>(
                  builder: (_, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          String id = generateUUID();
                          // showToast(id);
                          Organizer org = Organizer(
                              name: _organizerController.text.trim(),
                              location: "Bole Lingo Tower");
                          // Handle form submission
                          EventModel event = EventModel(
                            id: id,
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim(),
                            date: _dateController.text.trim(),
                            time: _timeController.text,
                            organizer: org,
                          );
                          try {
                            BlocProvider.of<EventBloc>(context)
                                .add(CreateEvent(event));
                          } catch (e) {
                            showToast(e.toString());
                          }
                        }
                      },
                      child: state is EventLoading
                          ? const CircularProgressIndicator()
                          : const Text('Post Event'),
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
}
