import 'package:ilebora_stk/ilebora_stk.dart';

void main(){

	final BoraSTK boraSTK = BoraSTK(
		userID: 'developer_user_id', //Provided ID
		apiKey: 'developer_api_key', //Provided ID
		phone: 'customer_phone_number', //Safaricom
		amount: '1', //Amount to pay
		orderID: '12345', //Order ID description
		displayName: 'BORA', //The name to display on the STK Push
		onSuccess: (BoraPushTransaction response){ //Do something with the response
			print('Payment Successful!');
			print(response);
		},
		onFailure: (String err) { //Do something on error
			print('Payment Failed!');
			print('Error: $err');
		},
	);

	// Show STK Screen
	// boraSTK.showSTKScreen(
	// 	context,
	// 	backgroundColor: Colors.white,
	// 	buttonColor: Colors.green,
	// 	textColor: Colors.white,
	// );

	// Show STK Dialog
	// boraSTK.showSTKDialog(
	// 	context,
	// 	backgroundColor: Colors.white,
	// 	buttonColor: Colors.green,
	// 	textColor: Colors.white,
	// );

}