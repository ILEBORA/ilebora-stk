import 'package:formz/formz.dart';

enum OrderIDValidationError { invalid }

class OrderID extends FormzInput<String, OrderIDValidationError> {
  const OrderID.pure() : super.pure('');
  const OrderID.dirty([String value = '']) : super.dirty(value);

  static final RegExp _orderIDRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]*$',
  );

  @override
  OrderIDValidationError? validator(String value) {
    if (value.isEmpty) {
      return null;
    }
    return _orderIDRegExp.hasMatch(value) && value.length < 30 ? null : OrderIDValidationError.invalid;
  }
}

extension Explanation on OrderIDValidationError {
  String? get name {
    switch (this) {
      case OrderIDValidationError.invalid:
        return "This is not a valid orderID";
      default:
        return null;
    }
  }
}