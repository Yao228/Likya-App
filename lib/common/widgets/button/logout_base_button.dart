import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/logout/logout_display_cubit.dart';
import 'package:likya_app/common/bloc/logout/logout_display_state.dart';

class LogoutBaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData iconName;
  const LogoutBaseButton({
    required this.onPressed,
    required this.iconName,
    this.title = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutStateCubit, LogoutState>(
      builder: (context, state) {
        if (state is LogoutLoadingState) {
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }

  Widget _loading(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey,
        backgroundColor: Color(0xFFCCCCCC),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      onPressed: null,
      icon: Icon(iconName, size: 28, color: Colors.black45),
      label: Text(
        title,
        style: TextStyle(
          color: Colors.black45,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _initial(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          backgroundColor: const Color(0x1AE8464E),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        onPressed: onPressed,
        icon: Icon(iconName, size: 28, color: Colors.red),
        label: Text(
          title,
          style: TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
