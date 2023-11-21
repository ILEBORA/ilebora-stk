import 'package:formz/formz.dart';

enum AmountError { empty, invalid }

class Amount extends FormzInput<String, AmountError> {
  const Amount.pure([String value = '']) : super.pure(value);
  const Amount.dirty([String value = '']) : super.dirty(value);

  static final RegExp _amountRegExp = RegExp(
    r'^(?=.*[a-z])[A-Za-z ]{2,}$',
  );

  @override
  AmountError? validator(String value) {
    if (value.isEmpty == true || value == "") {
      return AmountError.empty;
    }
    return _amountRegExp.hasMatch(value) && value.length < 10
        ? null
        : value.isEmpty
            ? null
            : AmountError.invalid;
  }
}

extension Explanation on AmountError {
  String? get amount {
    switch (this) {
      case AmountError.invalid:
        return "This is not a valid amount";
      default:
        return null;
    }
  }
}
