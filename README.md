A Flutter package for handling STK (Sim Toolkit) push payments. This package facilitates the integration of Safaricom's Lipa Na M-Pesa Online API for secure and seamless mobile payment processing.

## Features

    STK Push Payments: Initiate M-Pesa payments through STK push, providing a user-friendly experience.

## Installation

Add the following dependency to your pubspec.yaml file:

```yaml

dependencies:
  bora_stk: ^1.0.0
```

Then, run:

```bash

flutter pub get
```

## Usage

```dart

import 'package:bora_stk/bora_stk.dart';

void main() {
  // Initialize BoraSTK
  final boraSTK = BoraSTK(
    userID: 'your_user_id',
    apiKey: 'your_api_key',
    phone: '254712345678',
    amount: '100.00',
    orderID: 'unique_order_id',
    displayName: 'Display Name',
    onSuccess: () {
      print('Payment Successful');
    },
    onFailure: () {
      print('Payment Failed');
    },
  );

  // Show STK Screen
  boraSTK.showSTKScreen(
    context,
    backgroundColor: Colors.white,
    buttonColor: Colors.green,
    textColor: Colors.white,
  );

  // Show STK Dialog
  boraSTK.showSTKDialog(
    context,
    backgroundColor: Colors.white,
    buttonColor: Colors.green,
    textColor: Colors.white,
  );
}
```

## API Reference
**BoraSTK Class**
- **Constructors**

    BoraSTK({required userID, required apiKey, ...}): Initialize the BoraSTK instance with the necessary parameters.

- **Methods**

    generateToken(): Generate an authentication token for API requests.

    showSTKScreen(BuildContext context, {...}): Show the STK push screen as a new route.

    showSTKDialog(BuildContext context, {...}): Show the STK push screen within an AlertDialog.

## License

This project is licensed under the MIT License - see the LICENSE file for details.