import 'dart:async';
import 'dart:convert';

import 'package:ilebora_push/bora_push_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import "package:universal_html/html.dart" as html;

import '../constants.dart';
import '../models/amount.dart';
import '../models/orderid.dart';
import '../models/phone.dart';
import '../models/stk_payment_model.dart';
import '../repositories/api_helper.dart';
import '../models/stkpush_status.dart';
// import '../utils/bora_push_client.dart';

part 'stkpush_state.dart';

class STKPushCubit extends Cubit<STKPushState> {
	late BoraPushClient boraPushClient = BoraPushClient.create();
	late Stream myStream;
  	STKPushCubit() : super(STKPushState(status: STKPushStatus.initial));

  	void updateStatus(STKPushStatus status) => emit(state.copyWith(status: status, exceptionError:''));
    
	void setValues({required String orderID, required String amount, required String phone}) {
		return emit(state.copyWith(
				orderID: OrderID.dirty(orderID),
				amount: Amount.dirty(amount),
				phone: Phone.dirty(phone)
			));
  	}

  void orderIDChanged(String value) {
    final orderID = OrderID.dirty(value);
    emit(state.copyWith(
      orderID: orderID,
      status: STKPushStatus.initial
    ));
  }

  void amountChanged(String value) {
    final amount = Amount.dirty(value);
    emit(state.copyWith(
      amount: amount,
      status: STKPushStatus.initial
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: STKPushStatus.initial
    ));
  }



  Future<void> initiateSTKPush(String token) async {
    try {
      emit(state.copyWith(status: STKPushStatus.submissionInProgress, exceptionError:''));
      bool success = await requestSTK(
				token,
                state.orderID.value, 
                state.amount.value, 
                state.phone.value,
                (err)=>{
                  emit(state.copyWith(exceptionError:err))
                }
              );

      if(success){
        emit(state.copyWith(status: STKPushStatus.awaitingConfirmation));
      }else{
        emit(state.copyWith(status: STKPushStatus.error));
      }
      // 
    } catch (error) {
      emit(state.copyWith(
          exceptionError: "Unexpected error please try again later",
          status: STKPushStatus.failed));
    }
  }
  
	requestSTK(String token, String orderID, String amount, String phone, Function err) async {
		try{  
			String data = jsonEncode(<String, String>{
				"AccountReference": orderID,
				"amount": amount,
				"phone": phone,
				"diaplayName": 'BSTK',
			});

          	final response = await ApiHelper.callApi(
									AppConstants.pushURL, 
									data, 
									token: token
									);
			final jsonRes = jsonDecode(response.body);

			if (jsonRes['response'] != 'success') {
				closeConnection();
				emit(state.copyWith(status: STKPushStatus.submissionInProgress));
				err(jsonRes['message']);
			}else{
				closeConnection(); //Close previous connection
				emit(state.copyWith(status: STKPushStatus.awaitingConfirmation,exceptionError: ''));
				print('Add SSE listener');
				sseSubscribe(token, jsonRes['track']['CheckoutRequestID'],jsonRes['track']['userID'],'updates');
			}

		} catch (e) {
			// Handle exceptions, e.g., log the error or handle it appropriately.
			print('An error occurred: $e');
			emit(state.copyWith(status: STKPushStatus.error, exceptionError: '$e'));
			return false;
		}
  }
  
	Future<void> sseSubscribe(String token, String id, String usr, String event) async {
		var uri = Uri.parse('https://api.ilebora.com/assets/plugins/live/conn.bora');
		

		 var params = {
			'id': id,
			'userID':  usr,
			'event': event
		};

		uri = uri.replace(queryParameters: params);

		boraPushClient = BoraPushClient.connect(
			uri:  uri,
			withCredentials:true,
			closeOnError:true,
		);

		myStream = boraPushClient.stream;
		
		myStream.listen((value) {
			try{
				//Conert to JSON
				var jsonResp = jsonDecode(value); 

				if(jsonResp['response'] == 'cancelled'){
					//User cancelled the request
					closeConnection();
					emit(state.copyWith(status: STKPushStatus.customerCanceled));
				}else if(jsonResp['response'] == 'pending'){
					//awaitig confirmation
					emit(state.copyWith(status: STKPushStatus.awaitingConfirmation));
				}else if(jsonResp['response'] == 'success'){
					//The payment was received
					closeConnection();
				try{
					BoraPushTransaction transactionData = BoraPushTransaction.fromJson(jsonResp['data']['response']);
					
					emit(state.copyWith(status: STKPushStatus.success, transactionData: transactionData));
				}catch(e){
					print('Error parsing response $e');
					emit(state.copyWith(status: STKPushStatus.success));
				}
					
				}
				
			}catch(e){
				emit(state.copyWith(status: STKPushStatus.error, exceptionError: '$e'));
				//What to do? Retry | Close
			}
		});


	}

	void closeConnection() {
		boraPushClient.close();
	}

  

}