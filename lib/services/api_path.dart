class APIPath{
  static String pet(String uid,String petId) => '/user/$uid/pets/$petId';
  static String user(String uid) => '/user/$uid';
  static String users() => '/user';
  static String locations(String uid) => 'locations';
  static String pets(String uid) => '/user/$uid/pets';
  static String vets()=>'/vet';
  static String vet(String uid) => '/vet/$uid';
  static String appointment(String uid,String appointmentId) => '/user/$uid/appointments/$appointmentId';
  static String appointmentVet(String uidVet,String appointmentId) => '/vet/$uidVet/appointments/$appointmentId';
  static String appointments(String uid) => '/vet/$uid/appointments';
  static String items(String category)=>'/itemsApp/$category/products';
  static String cartItems(String uid,String itemUID)=>'/user/$uid/cart/$itemUID';
  static String userCart(String uid)=>'/user/$uid/cart';
  static String userCartItem(String uid,String itemId) => '/user/$uid/cart/$itemId';

  static String wishlistItems(String uid,String itemUID)=>'/user/$uid/wishlist/$itemUID';
  static String userWishlist(String uid)=>'/user/$uid/wishlist';
  static String userWishlistItem(String uid,String itemId) => '/user/$uid/wishlist/$itemId';
  static String itemsApp()=>'/itemsApp';
  static String pincodes()=> '/pincode';
  static String homePage()=>'/homepage';

  static String prevOrderStream(String uid)=>'/user/$uid/prevOrdersApp';
  static String cart(String uid)=>'/user/$uid/cart';
  static String prevOrder(String uid,String orderID)=>'/user/$uid/prevOrdersApp/$orderID';

  static String particularOrder(String orderId) => '/orders_app/$orderId';
  static String notification(String uid,String notificationId) => '/vet/$uid/notifications/$notificationId';
  static String notifications(String uid) => '/vet/$uid/notifications';
}