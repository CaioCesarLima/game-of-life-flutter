import 'dart:math';

import 'package:game_of_life/model/item_model.dart';
import 'package:rx_notifier/rx_notifier.dart';

final numberCells = RxNotifier<int>(30);
final numberCols = RxNotifier<int>(30);
final board = RxNotifier<List<List<ItemModel>>>(getInitialBoard());

List<List<ItemModel>> getInitialBoard() {
    return List.generate(
        numberCols.value,
        (index) => List.generate(
            numberCells.value,
            (index) => Random().nextInt(100) % 3 == 0
                ? ItemModel(true)
                : ItemModel(false)));
  }

final updateCells = RxNotifier.action();