import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';

import '../blocs/stkpush_cubit.dart';
import '../models/stkpush_status.dart';
import '../utils/validator_utils.dart';

late Widget pushStatus = Container();
late Widget buttonStatus = Text('Lipa na Mpesa');

class STKPushScreen extends StatelessWidget {

	final String token;
	final String orderID;
	final String amount;
	final String phone;
	final Function onSuccess;
	final Function onFailure;
	final Color backgroundColor;
	final Color buttonColor;
	final Color textColor;
	final bool showTests;

	STKPushScreen({super.key, 
		required this.token,
		required this.orderID,
		required this.amount,
		required this.phone,
		required this.onSuccess,
		required this.onFailure,
		this.backgroundColor = Colors.white,
		this.buttonColor = Colors.blue,
		this.textColor = Colors.black,
		this.showTests = false,
	});

 
		

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('M-Pesa STK Push Status'),
			),
			body: BlocListener<STKPushCubit, STKPushState>(
        listener: (context, state) {
          if(state.status == STKPushStatus.awaitingConfirmation){
            pushStatus = const Text('Awaiting Confirmation!');
          }else if(state.status == STKPushStatus.success){
            onSuccess(state.transactionData);
            pushStatus = const Text('Payment Received!');
          }else if(state.status == STKPushStatus.customerCanceled){
            pushStatus = const Text('Customer canceled!');
          // }else if(state.status == STKPushStatus.failed){
            // pushStatus = const Text('Request Failed!');
          }else if(state.status == STKPushStatus.error){
             onFailure(state.exceptionError);
            pushStatus = const Text('Error: something went wrong!');
          }

          if(state.status == STKPushStatus.submissionInProgress){
            buttonStatus = CircularProgressIndicator();
          }else{
            buttonStatus = Text('Lipa na Mpesa', style: TextStyle(color: textColor));
          }

        },
        child:BlocBuilder<STKPushCubit, STKPushState>(
				builder: (context, stkState) {
				
				return SingleChildScrollView(
				padding: const EdgeInsets.all(30.0),
				child: Container(
							padding: const EdgeInsets.all(8.0),
							child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								_stkHeader(context),
								_stkForm(context,stkState),
								(showTests) ? _stkTest(context, stkState) : Container(),
							],
							),
						)
					);
				},
			),
      )
		);
	}
  
  Widget _stkHeader(BuildContext context) {
    return Column(
      children: [
        	const Image(
                    image: AssetImage('assets/images/mpesa.png', package: 'ilebora_stk'),
					// width: 30.0,
					// height: 50.0,
				),
    		RichText(
					text: TextSpan(
						style: DefaultTextStyle.of(context).style,
						children: <InlineSpan>[
							const WidgetSpan(
								alignment: PlaceholderAlignment.middle,
								child: Padding(
								padding: EdgeInsets.only(left: 4.0),
								child: 
									Image(
										image: AssetImage('assets/images/icon.png', package: 'ilebora_stk'),
										width: 30.0,
										height: 30.0,
									),
								),
							),
							const TextSpan(
								text: 'BoraSTK ',
								style: TextStyle(fontSize: 20.0),
							),
							WidgetSpan(
								alignment: PlaceholderAlignment.middle,
								child: Padding(
								padding: const EdgeInsets.only(top: 2.0),
								child: _showVersion(),
								),
							),
						
						],
					),
				)
			]
		);
  }

	final GlobalKey<FormState> _formKey = GlobalKey();

  	final FocusNode _focusNodeAmount = FocusNode();
	final FocusNode _focusNodePhone = FocusNode();

	final TextEditingController _controllerOrderID = TextEditingController();
	final TextEditingController _controllerAmount = TextEditingController();
	final TextEditingController _controllerPhone = TextEditingController();
  
  	Widget _stkForm(BuildContext context, STKPushState stkStatus) {
		_controllerOrderID.text = orderID;
		_controllerAmount.text = amount;
		_controllerPhone.text = phone;

		context.read<STKPushCubit>().setValues(
			orderID: orderID,
			amount: amount,
			phone: phone
		);

		return Stack(children: [
					Form(
						key: _formKey,
						child: SingleChildScrollView(
						padding: const EdgeInsets.all(30.0),
						child: Column(
							children: [
								TextFormField(
									controller: _controllerOrderID,
									keyboardType: TextInputType.name,
									decoration: InputDecoration(
									labelText: "Order ID",
									prefixIcon: const Icon(Icons.person_outline),
									border: OutlineInputBorder(
										borderRadius: BorderRadius.circular(10),
									),
									enabledBorder: OutlineInputBorder(
										borderRadius: BorderRadius.circular(10),
									),
									),
									onEditingComplete: () => _focusNodeAmount.requestFocus(),
									onChanged: (orderID) => context.read<STKPushCubit>().amountChanged(orderID),
									validator: (String? value) {
										String validOrderID = ValidationUtils.validateOrderID(value.toString());
										if (value == null || value.isEmpty) {
											return "Please enter orderID.";
										}
										else if(validOrderID.isNotEmpty){
											return validOrderID;
										}

										return null;
									},
								),
								const SizedBox(height:20),
								TextFormField(
									controller: _controllerAmount,
									keyboardType: TextInputType.number,
									inputFormatters: [
										FilteringTextInputFormatter.allow(
										RegExp("[0-9]"),
										),
									],
									decoration: InputDecoration(
									labelText: "Amount",
									prefixIcon: const Icon(Icons.person_outline),
									border: OutlineInputBorder(
										borderRadius: BorderRadius.circular(10),
									),
									enabledBorder: OutlineInputBorder(
										borderRadius: BorderRadius.circular(10),
									),
									),
									onEditingComplete: () => _focusNodePhone.requestFocus(),
									onChanged: (amount) => context.read<STKPushCubit>().amountChanged(amount),
									validator: (String? value) {
										String validAmount = ValidationUtils.validateAmount(value.toString());

										if (value == null || value.isEmpty) {
											return "Please enter Amount.";
										}
										else if(validAmount.isNotEmpty){
											return validAmount;
										}

										return null;
									},
								),
								const SizedBox(height:20),
								TextFormField(
									controller: _controllerPhone,
									keyboardType: TextInputType.name,
									decoration: InputDecoration(
									labelText: "Phone",
									prefixIcon: const Icon(Icons.person_outline),
									border: OutlineInputBorder(
										borderRadius: BorderRadius.circular(10),
									),
									enabledBorder: OutlineInputBorder(
										borderRadius: BorderRadius.circular(10),
									),
									),
									
									onChanged: (phone) => context.read<STKPushCubit>().phoneChanged(phone),
									validator: (String? value) {
										String validPhone = ValidationUtils.validateOrderID(value.toString());
									
										if (value == null || value.isEmpty) {
											return "Please enter Phone Number.";
										}
										else if(validPhone.isNotEmpty){
											return validPhone;
										}
									

									return null;
									},
								),
								const SizedBox(height:20),
								pushStatus,
								ElevatedButton(
								onPressed: () {
									// print('Call STK Push...');
									if (_formKey.currentState?.validate() ?? false) {
										BlocProvider.of<STKPushCubit>(context).initiateSTKPush(token);
									}
								},
								style: ButtonStyle(
									backgroundColor: MaterialStateProperty.all(buttonColor),
								),
								child: buttonStatus,
								),
								const SizedBox(height:20),
								ElevatedButton(
									onPressed: () {
										onFailure();
                    					BlocProvider.of<STKPushCubit>(context).closeConnection();
										Navigator.pop(context); // Close the confirmation screen
									},
									style: ButtonStyle(
										backgroundColor: MaterialStateProperty.all(buttonColor),
									),
									child: Text('Cancel', style: TextStyle(color: textColor)),
								),

								ElevatedButton(
									onPressed: () {
										//Test SSE
										BlocProvider.of<STKPushCubit>(context).sseSubscribe(token,'93928-38595962-1', '2474fe29a7afd3e05c058dccfd94a826', 'updates');
									},
									style: ButtonStyle(
										backgroundColor: MaterialStateProperty.all(buttonColor),
									),
									child: Text('Test SSE Client', style: TextStyle(color: textColor)),
								),
							],
						) 
						)
					)
				]	
			);
	}
	
	_stkTest(BuildContext context, stkState) {
		// Simulate a change in STK status
		return Column(
      children: [
			Text('STK Push Status: ${stkState.status}'),
				ElevatedButton(
					onPressed: () {		
						context.read<STKPushCubit>().updateStatus(STKPushStatus.awaitingConfirmation);
					},
					child: const Text('Simulate Awaiting User'),
				),
				ElevatedButton(
					onPressed: () {		
						context.read<STKPushCubit>().updateStatus(STKPushStatus.customerCanceled);
					},
					child: const Text('Simulate Canceled by User'),
				),
				ElevatedButton(
					onPressed: () {
						context.read<STKPushCubit>().updateStatus(STKPushStatus.success);
					},
					child: const Text('Simulate Success'),
				),
				ElevatedButton(
					onPressed: () {
						context.read<STKPushCubit>().updateStatus(STKPushStatus.failed);
					},
					child: const Text('Simulate Failure'),
				),
        ElevatedButton(
					onPressed: () {
						context.read<STKPushCubit>().updateStatus(STKPushStatus.submissionInProgress);
					},
					child: const Text('Simulate Loading'),
				),
				ElevatedButton(
					onPressed: () {
						context.read<STKPushCubit>().updateStatus(STKPushStatus.error);
					},
					child: const Text('Simulate Error'),
				),
			]
		);
	 }

	Widget _showVersion(){
		return const Text(
					'v0.0.1',
					style: TextStyle(fontSize: 12.0, textBaseline: TextBaseline.alphabetic),
				);
		// return FutureBuilder<PackageInfo>(
		// 	future: PackageInfo.fromPlatform(),
		// 	builder: (context, snapshot) {
		// 		if (snapshot.connectionState == ConnectionState.waiting) {
		// 			return const CircularProgressIndicator(); 
		// 		}

		// 		if (snapshot.hasError) {
		// 			print('Error: ${snapshot.error}');
		// 			return Text('Error: ${snapshot.error}');
		// 		}

		// 		final packageInfo = snapshot.data;

		// 		return Text('Package Version: ${packageInfo?.version}');
		// 	},
		// 	);
	}
}
