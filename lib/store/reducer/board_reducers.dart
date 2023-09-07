import 'package:game_of_life/store/atom/board_atoms.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../model/item_model.dart';

class BoardReducer extends RxReducer {
  BoardReducer() {
    on(() => [updateCells], _updateCells);
  }

  void _updateCells() {
    List<List<ItemModel>> newBoard = board.value
        .map((e) => e.map((e) => ItemModel(e.isItemALive)).toList())
        .toList();

    for (int col = 0; col < numberCols.value; col++) {
      for (int row = 0; row < numberCells.value; row++) {
        int vizinhoAlive = _vizinhoVivos(col, row);
        bool currentIsAlive = newBoard[col][row].isItemALive;

        if (!currentIsAlive && vizinhoAlive == 3) {
          newBoard[col][row].revive();
        } else if (currentIsAlive && vizinhoAlive != 2 && vizinhoAlive != 3) {
          newBoard[col][row].die();
        }
      }
    }

    board.setValue(newBoard);
  }

  int _vizinhoVivos(int col, int row) {
    int vizinhosVivos = 0;
    for (int cols = -1; cols <= 1; cols++) {
      for (int rows = -1; rows <= 1; rows++) {
        final cellRow = row + rows;
        final cellCol = col + cols;
        bool outRange = cellRow < 0 ||
            cellRow > numberCells.value - 1 ||
            cellCol < 0 ||
            cellCol > numberCols.value - 1;
        bool isNeighBourCell = cols != 0 || rows != 0;

        if (!outRange &&
            isNeighBourCell &&
            board.value[cellCol][cellRow].isItemALive) {
          vizinhosVivos++;
        }
      }
    }
    return vizinhosVivos;
  }
}
