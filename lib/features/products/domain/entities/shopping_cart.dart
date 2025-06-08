class ShoppingCart {
  
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double totalPrice;

  ShoppingCart({
    required this.productId, 
    required this.name, 
    required this.image, 
    required this.quantity, 
    required this.totalPrice
  });
}