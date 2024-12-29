import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';

import '../../bloc/button/button_state.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  const BasicAppButton(
      {required this.onPressed,
      this.title = '',
      this.height,
      this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }

  Widget _loading(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.grey,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget _initial(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              width ?? MediaQuery.of(context).size.width,
              height ?? 50,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: const Color(0xFF2FA9A2),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}
