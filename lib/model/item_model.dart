
class ItemModel {
  late bool isAlive;
  
  ItemModel(this.isAlive);

  bool get isItemALive => isAlive;
  void die() => isAlive = false;
  void revive() => isAlive = true;
}