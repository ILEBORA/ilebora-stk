import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/stkpush_cubit.dart';
import 'screens/stkpush_screen.dart';

export 'models/stk_payment_model.dart';

class BoraSTK {
	String phone;
	String amount;
	String orderID;
	String displayName;
	Function onSuccess;
	Function onFailure;
  bool showTests = false;

	String userID;
	String apiKey;

	BoraSTK({
		required this.userID,
		required this.apiKey,
		required this.phone,
		required this.amount,
		required this.orderID,
		required this.displayName,
		required this.onSuccess,
		required this.onFailure,
	});

	final STKPushCubit stkPushCubit = STKPushCubit();

	String generateToken(){
		final token = base64Encode(utf8.encode('$userID:$apiKey'));
		return token;
	}
	
	void showSTKScreen(BuildContext context, {
		Color backgroundColor = Colors.white,
		Color buttonColor = Colors.green,
		Color textColor = Colors.white,
    bool showTests = false
	}) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => BlocProvider.value(
				value: stkPushCubit,
				child: STKPushScreen(
						token: generateToken(),
						orderID : orderID,
						amount: amount,
						phone: phone,
						onSuccess: onSuccess,
						onFailure: onFailure,
            showTests: showTests,
            backgroundColor: backgroundColor,
            buttonColor: buttonColor,
            textColor: textColor,
				),
				),
			),
			);
			
	}

	void showSTKDialog(BuildContext context, {
		Color backgroundColor = Colors.white,
		Color buttonColor = Colors.green,
		Color textColor = Colors.white,
    bool showTests = false
	}) {
		// Shows a dialog containing a confirmation screen
		showDialog(
		context: context,
		builder: (context) => BlocProvider.value(
				value: stkPushCubit,
				child: AlertDialog(
					contentPadding: EdgeInsets.zero,
					content: STKPushScreen(
					  token: generateToken(),
						orderID : orderID,
						amount: amount,
						phone: phone,
						onSuccess: onSuccess,
						onFailure: onFailure,
            showTests: showTests,
            backgroundColor: backgroundColor,
            buttonColor: buttonColor,
            textColor: textColor,
					),
				),
			)
		);
	}
  
}