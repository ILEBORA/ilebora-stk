// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'stkpush_cubit.dart';

class STKPushState extends Equatable {

  STKPushState({
    this.orderID = const OrderID.pure(),
    this.amount = const Amount.pure(),
    this.phone = const Phone.pure(),
    required this.status,
    this.exceptionError = "",
    BoraPushTransaction? transactionData,
  }) : transactionData = transactionData ?? BoraPushTransaction(); // Change here

  final OrderID orderID;
  final Amount amount;
  final Phone phone;
  final STKPushStatus status;
  final String exceptionError;
  final BoraPushTransaction transactionData;


  @override
  List<Object?> get props => [orderID, amount, phone, status, exceptionError];

  STKPushState copyWith({
    OrderID? orderID,
    Amount? amount,
    Phone? phone,
    STKPushStatus? status,
    String? exceptionError,
    BoraPushTransaction? transactionData,
  }) {
    return STKPushState(
      orderID: orderID ?? this.orderID,
      amount: amount ?? this.amount,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
      transactionData: transactionData ?? this.transactionData,
    );
  }
  
  	@override
	String toString() => 'STKPushState(status: $status, exceptionError: $exceptionError)';

}
