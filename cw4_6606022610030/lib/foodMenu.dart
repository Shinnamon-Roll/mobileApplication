class FoodMenu {
  String name;
  String price;
  String img;
  String type; 
  bool isSelected; 

  FoodMenu(this.name, this.price, this.img, this.type, {this.isSelected = false});
}
