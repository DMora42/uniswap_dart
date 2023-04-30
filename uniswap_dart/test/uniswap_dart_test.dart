// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, avoid_print

import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:uniswap/abi/router.dart';
import 'package:erc20/erc20.dart';

//Future<String> swapETHForExactTokens() async {}

Future<String> swapExactETHForTokens(String credentials, num amountOutput,
    String tokenOut, String recipient, int timestamp) async {
  try {
    final amountOutMin = BigInt.from(amountOutput).pow(18);
    final eth = '0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6';
    final path = [
      EthereumAddress.fromHex(eth),
      EthereumAddress.fromHex(tokenOut)
    ];
    final to = EthereumAddress.fromHex(recipient);
    final deadline = BigInt.from(timestamp);
    final rpc = 'https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';
    final provider = Web3Client(rpc, Client());
    final routerAddress =
        EthereumAddress.fromHex('0x10ED43C718714eb63d5aA57B78B54704E256024E');
    final routerAbi = ContractAbi.fromJson(abi, 'Router');
    final routerContract = DeployedContract(routerAbi, routerAddress);
    final function = routerContract.function('swapExactETHForTokens');
    final token = ERC20(
      address: EthereumAddress.fromHex(eth),
      client: provider,
    );
print('Appovi');
    await token.approve(
        credentials: EthPrivateKey.fromHex(credentials),
        routerAddress,
        amountOutMin);
    final result = await provider.sendTransaction(
      EthPrivateKey.fromHex(credentials),
      Transaction.callContract(
        contract: routerContract,
        function: function,
        parameters: [
          amountOutMin,
          path,
          to,
          deadline,
        ],
      ),
      chainId: 5,
    );
    return result;
  } catch (err) {
    throw Exception(err);
  }
}

/*Future<String> swapExactTokensForETH() async {}

Future<String> swapTokensForExactTokens() async {}*/

Future<String> swapExactTokensForTokens(
    String credentials,
    num amountInput,
    num amountOutput,
    String tokenIn,
    String tokenOut,
    String recipient,
    int timestamp) async {
  final amountIn = BigInt.from(amountInput).pow(18);
  final amountOutMin = BigInt.from(amountOutput).pow(18);
  final path = [
    EthereumAddress.fromHex(tokenIn),
    EthereumAddress.fromHex(tokenOut)
  ];
  final to = EthereumAddress.fromHex(recipient);
  final deadline = BigInt.from(timestamp);
  final rpc = 'https://bsc-dataseed.binance.org/';
  final provider = Web3Client(rpc, Client());
  final routerAddress =
      EthereumAddress.fromHex('0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D');
  final routerAbi = ContractAbi.fromJson(abi, 'Router');
  final routerContract = DeployedContract(routerAbi, routerAddress);
  final function = routerContract.function('swapExactTokensForTokens');
  final result = await provider.sendTransaction(
    EthPrivateKey.fromHex(credentials),
    Transaction.callContract(
      contract: routerContract,
      function: function,
      parameters: [
        amountIn,
        amountOutMin,
        path,
        to,
        deadline,
      ],
      // value: EtherAmount.inWei(value),
    ),
  );
  return result;
}

/*Future<String> swapTokensForExactETH() async {}

Future<String> swapExactETHForTokensSupportingFeeOnTransferTokens() async {}

Future<String> swapExactTokensForETHSupportingFeeOnTransferTokens() async {}

Future<String> swapExactTokensForTokensSupportingFeeOnTransferTokens() async {}*/

void main() async {
  final deadline =
      DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch ~/
          1000;
  await swapExactETHForTokens(
      '3d22d4073e2f9f1ec98bfd59f682f4744c92d1c070252230c3bf900e724a644c',
      1,
      '0x7af963cF6D228E564e2A0aA0DdBF06210B38615D',
      '0x5fEfE2176aEDD83120D329156f3d9921E7a147e8',
      deadline);
}
