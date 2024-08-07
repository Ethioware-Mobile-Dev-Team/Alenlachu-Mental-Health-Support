import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/blocs/common/profile/profile_cubit.dart';
import 'package:alenlachu_app/blocs/common/profile/profile_state.dart';

import 'package:alenlachu_app/presentation/common/widgets/custome_button.dart';
import 'package:alenlachu_app/presentation/common/widgets/form_container.dart';
import 'package:alenlachu_app/presentation/common/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationBloc>().state;
    if (authState is Authenticated) {
      _nameController.text = authState.user!.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          centerTitle: true,
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is Updating) {
              showSnackbarMessage(context, "Updating");
            } else if (state is Updated) {
              showSnackbarMessage(context, "Data Updated Successfully");
              Navigator.of(context).pop;
            } else if (state is NotUpdated) {
              showSnackbarMessage(context, state.error);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: state.user!.photoUrl == null
                                ? const AssetImage("assets/images/Profile.png")
                                : NetworkImage(state.user!.photoUrl!),
                            radius: 50,
                          ),
                          Positioned(
                            top: 70,
                            left: 30,
                            child: GestureDetector(
                              onTap: () async {
                                await BlocProvider.of<ProfileCubit>(context)
                                    .pickImage();
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainer(
                  controller: _nameController,
                  labelText: 'name',
                  inputType: TextInputType.text,
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ImagePicked) {
                      return CustomButton(
                          name: 'Save',
                          width: 100,
                          onPressed: () async {
                            await BlocProvider.of<ProfileCubit>(context)
                                .updateProfile(imageFilePath: state.image);
                          });
                    } else if (state is Updating) {
                      return const CircularProgressIndicator();
                    } else {
                      return CustomButton(
                          name: 'Update',
                          width: 100,
                          onPressed: () async {
                            if (_nameController.text.isNotEmpty) {
                              await BlocProvider.of<ProfileCubit>(context)
                                  .updateName(_nameController.text.trim());
                            }
                          });
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
