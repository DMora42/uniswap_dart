// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:uniswap/uniswap.dart';


void main() async {
  final credentials =
      '3d22d4073e2f9f1ec98bfd59f682f4744c92d1c070252230c3bf900e724a644c';
  final payableAmount = 0.000001;
  final tokenOut = '0x2f3A40A3db8a7e3D09B0adfEfbCe4f6F81927557';
  final recipient = '0x5fEfE2176aEDD83120D329156f3d9921E7a147e8';
  final deadline =
      DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch ~/
          1000;
  await swapExactETHForTokens(credentials, payableAmount, tokenOut, recipient, deadline);
}
