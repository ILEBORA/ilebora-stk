// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BoraPushTransaction {

  	int id;
    int Status;
    String MerchantRequestID;
    String CheckoutRequestID;
    int ResultCode;	
    String ResultDesc;
    int ResponseCode;
    String ResponseDescription;
    String CustomerMessage;
    double Amount;
    String MpesaReceiptNumber;
    double Balance;
    String TransactionDate;
    String PhoneNumber;
    String dateAdded;
    String dateModified;

	BoraPushTransaction({
		this.id = 0,
		this.Status = 0,
		this.MerchantRequestID = '',
		this.CheckoutRequestID = '',
		this.ResultCode = 0,	
		this.ResultDesc = '',
    this.ResponseCode = 0,
		this.ResponseDescription = '',
		this.CustomerMessage = '',
		this.Amount = 0,
		this.MpesaReceiptNumber = '',
		this.Balance = 0,
		this.TransactionDate = '',
		this.PhoneNumber = '',
		this.dateAdded = '',
		this.dateModified = '',
	});


	factory BoraPushTransaction.fromJson(Map<String, dynamic> jsonData){

		var usr = BoraPushTransaction(
			id					: int.parse(jsonData['id']??0),
			Status				: int.parse(jsonData['Status']??0),
			MerchantRequestID	: jsonData['MerchantRequestID']??'',
			CheckoutRequestID	: jsonData['CheckoutRequestID']??'',
			ResultCode			: int.parse(jsonData['ResultCode']??0),
			ResultDesc			: jsonData['ResultDesc']??'',
      ResponseCode			: int.parse(jsonData['ResponseCode']??''),
			ResponseDescription	: jsonData['ResponseDescription']??'',
			CustomerMessage		: jsonData['CustomerMessage']??0,
			Amount				      : double.parse(jsonData['Amount']??0),
			MpesaReceiptNumber	: jsonData['MpesaReceiptNumber']??'',
      Balance	            : double.parse(jsonData['Balance']??0),
			dateAdded 			: jsonData['date_added']??'',
			dateModified		: jsonData['date_modified']??'',
		);


    //        id: 198,
    //       Status: 1,
    //       userID: 2474fe29a7afd3e05c058dccfd94a826,
    //       apiKey: 6d11ff07-6cd4-11ee-97dc-5254009db90d,
    //       MerchantRequestID: 84126-40651487-1,
    //       CheckoutRequestID: ws_CO_19112023110638688741136255,
    //       ResultCode: 0,
    //       ResultDesc: The service request is processed
    //         successfully.,
    //       ResponseCode: 0,
    //       ResponseDescription: Success. Request accepted for processing,
    //       CustomerMessage: Success.
    //         Request accepted for processing,
    //       Amount: 1,
    //       MpesaReceiptNumber: RKJ8R626PM,
    //       Balance: 0,
    //       TransactionDate: 20231119110654,
    //       PhoneNumber: 254741136255,
    //       date_added: 2023-11-19 08:06:39,
    //       date_modified: 2023-11-19
    //         08:06:55,
		
		return usr;
	}

  static Map<String, dynamic> toMap(BoraPushTransaction model) => 
    <String, dynamic> {
		'id'					: model.id,
		'Status'				: model.Status,
		'MerchantRequestID'		: model.MerchantRequestID,
		'CheckoutRequestID'		: model.CheckoutRequestID,
		'ResultCode'			: model.ResultCode,
		'ResultDesc'			: model.ResultDesc,
		'ResponseDescription'	: model.ResponseDescription,
		'CustomerMessage'		: model.CustomerMessage,
		'Amount'				: model.Amount,
		'MpesaReceiptNumber'	: model.MpesaReceiptNumber,
		'dateAdded' 			: model.dateAdded,
		'dateModified'			: model.dateModified,
	};

  	static String serialize(BoraPushTransaction model) => json.encode(BoraPushTransaction.toMap(model));

  	static BoraPushTransaction deserialize(String json) => BoraPushTransaction.fromJson(jsonDecode(json));

	@override
	String toString() => 'BoraPushTransaction(${this.id}, ${this.Status}, ${this.MerchantRequestID}, ${this.CheckoutRequestID}, ${this.ResultCode}, ${this.ResultDesc}, ${this.ResponseDescription}, ${this.CustomerMessage}, ${this.Amount}, ${this.MpesaReceiptNumber}, ${this.Balance}, ${this.TransactionDate}, ${this.PhoneNumber}, ${this.dateAdded}, ${this.dateModified} )';



  BoraPushTransaction copyWith({
    int? id,
    int? Status,
    String? MerchantRequestID,
    String? CheckoutRequestID,
    int? ResultCode,
    String? ResultDesc,
    String? ResponseDescription,
    String? CustomerMessage,
    double? Amount,
    String? MpesaReceiptNumber,
    double? Balance,
    String? TransactionDate,
    String? PhoneNumber,
    String? dateAdded,
    String? dateModified, required String orderID,
  }) {
    return BoraPushTransaction(
      id: id ?? this.id,
      Status: Status ?? this.Status,
      MerchantRequestID: MerchantRequestID ?? this.MerchantRequestID,
      CheckoutRequestID: CheckoutRequestID ?? this.CheckoutRequestID,
      ResultCode: ResultCode ?? this.ResultCode,
      ResultDesc: ResultDesc ?? this.ResultDesc,
      ResponseDescription: ResponseDescription ?? this.ResponseDescription,
      CustomerMessage: CustomerMessage ?? this.CustomerMessage,
      Amount: Amount ?? this.Amount,
      MpesaReceiptNumber: MpesaReceiptNumber ?? this.MpesaReceiptNumber,
      Balance: Balance ?? this.Balance,
      TransactionDate: TransactionDate ?? this.TransactionDate,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      dateAdded: dateAdded ?? this.dateAdded,
      dateModified: dateModified ?? this.dateModified,
    );
  }
}
