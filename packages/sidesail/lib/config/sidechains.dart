import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sail_ui/sail_ui.dart';
import 'package:sidesail/providers/process_provider.dart';

abstract class Sidechain {
  String get name;
  int get slot;
  Color get color;
  SidechainType get type;

  // TODO: turn this into a function that takes a regtest/signet/whatever param
  int get rpcPort;

  String get ticker {
    return 'SC$slot';
  }

  String get binary;

  static Sidechain? fromString(String input) {
    switch (input.toLowerCase()) {
      case 'ethereum':
      case 'ethside':
        return EthereumSidechain();

      case 'testchain':
        return TestSidechain();

      case 'zcash':
      case 'zside':
        return ZCashSidechain();
    }
    return null;
  }
}

class TestSidechain extends Sidechain {
  @override
  String name = 'Testchain';

  @override
  int slot = 0;

  @override
  Color color = SailColorScheme.orange;

  @override
  SidechainType get type => SidechainType.testChain;

  @override
  int get rpcPort => 18743;

  @override
  String get binary => 'testchaind';
}

class ZCashSidechain extends Sidechain {
  @override
  String name = 'zSide';

  @override
  int slot = 5;

  @override
  Color color = SailColorScheme.blue;

  @override
  SidechainType get type => SidechainType.zcash;

  @override
  int get rpcPort => 20000;

  @override
  String get binary => 'zsided';
}

class EthereumSidechain extends Sidechain {
  @override
  String name = 'EthSide';

  @override
  int slot = 6;

  @override
  Color color = SailColorScheme.purple;

  @override
  SidechainType get type => SidechainType.ethereum;

  @override
  int get rpcPort => 8545;

  @override
  String get binary => 'sidegeth';
}

enum SidechainType { testChain, ethereum, zcash }

extension SidechainPaths on SidechainType {
  String confFile() {
    switch (this) {
      case SidechainType.testChain:
        return 'testchain.conf';
      case SidechainType.ethereum:
        // TODO: make this properly configurable
        return 'config.toml';
      case SidechainType.zcash:
        // TODO: make this properly configurable
        return 'zcash.conf';
    }
  }

  String datadir() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE']; // windows!
    if (home == null) {
      throw 'unable to determine HOME location';
    }

    if (Platform.isLinux) {
      return filePath([
        home,
        _linuxDirname(),
      ]);
    } else if (Platform.isMacOS) {
      return filePath([
        home,
        'Library',
        'Application Support',
        _macosDirname(),
      ]);
    } else if (Platform.isWindows) {
      return filePath([
        home,
        'AppData',
        'Roaming',
        _windowsDirname(),
      ]);
    } else {
      throw 'unsupported operating system: ${Platform.operatingSystem}';
    }
  }

  String _linuxDirname() {
    switch (this) {
      case SidechainType.testChain:
        return '.testchain';
      case SidechainType.ethereum:
        // TODO: correct?
        return '.ethside';
      case SidechainType.zcash:
        // TODO: correct?
        return '.zside';
    }
  }

  String _macosDirname() {
    switch (this) {
      case SidechainType.testChain:
        return 'Testchain';
      case SidechainType.ethereum:
        return 'EthSide';
      case SidechainType.zcash:
        return 'ZSide';
    }
  }

  String _windowsDirname() {
    switch (this) {
      case SidechainType.testChain:
        return 'Testchain';
      case SidechainType.ethereum:
        return 'EthSide';
      case SidechainType.zcash:
        return 'ZSide';
    }
  }
}
