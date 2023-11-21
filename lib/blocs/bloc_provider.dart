import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'stkpush_cubit.dart';

class BlocProviderContainer extends StatelessWidget {
  final Widget child;

  const BlocProviderContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => STKPushCubit(),
      child: child,
    );
  }
}
