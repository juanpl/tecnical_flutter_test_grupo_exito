
class ShoppingCart {
  
  final List<ShoppingCartProduct> productList;
  final double totalShoppingCartPrice;

  ShoppingCart({
    required this.productList,
    required this.totalShoppingCartPrice
  });

}

class ShoppingCartProduct {

  final int productId;
  final String name;
  final String image;
  final String category;
  final int price;
  final int quantity;

  ShoppingCartProduct({
    required this.productId, 
    required this.name, 
    required this.image, 
    required this.category, 
    required this.price, 
    required this.quantity
  });

}