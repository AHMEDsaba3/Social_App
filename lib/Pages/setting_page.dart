import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dark mode"),
            Switch(value: AppCubit.get(context).isDark, onChanged: (value) {
              AppCubit.get(context).ToggleIsDark();
            },),
          ],
        )
        );
      },
    );
  }
}
