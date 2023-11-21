class ValidationUtils {
  ValidationUtils._();

  


  static String validateOrderID(String value) {
    if (value.length < 3) {
      return 'Order ID must be more than 2 charater';
    } else {
      return '';
    }
  }

  static String validateAmount(String value) {
    if (int.parse(value) > 0) {
      return 'Amount must be a positive number';
    } else {
      return '';
    }
  }


  String validateMobile(String value) {
    // Safaricom Mobile number are of 10 digit only
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return '';
    }
  }

  static bool isValidEmail(String email){
      	return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }  	

  String validateEmail(String value) {
    if (!isValidEmail(value)) {
      return 'Enter Valid Email';
    } else {
      return 'null';
    }
  }

}