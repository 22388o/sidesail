import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sail_ui/sail_ui.dart';
import 'package:sidesail/console.dart';
import 'package:sidesail/deposit_address.dart';
import 'package:sidesail/rpc/rpc.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SailPage(
      title: 'SideSail',
      body: ViewModelBuilder.reactive(
        viewModelBuilder: () => HomePageViewModel(),
        builder: ((context, viewModel, child) {
          return Center(
            child: SizedBox(
              width: 1200,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(child: RpcWidget()),
                    ],
                  ),
                  const Row(
                    children: [Text('Deposit stuff')],
                  ),
                  Row(
                    children: [
                      DepositAddress(viewModel.depositAddress),
                      ElevatedButton(
                        onPressed: viewModel.generateDepositAddress,
                        child: const Text('Generate'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class HomePageViewModel extends BaseViewModel {
  final log = Logger(level: Level.debug);
  RPC get _rpc => GetIt.I.get<RPC>();

  final TextEditingController withdrawalAddress = TextEditingController();
  final TextEditingController withdrawalAmount = TextEditingController();

  String depositAddress = 'none';

  Future<void> generateDepositAddress() async {
    var address = await _rpc.generateDepositAddress();
    depositAddress = address;
    notifyListeners();
  }
}
