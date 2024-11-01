import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> products;
  List<Product> cart = [];
  int totalPrice = 0;

  ShoppingMall(this.products);

  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price} 원');
    }
  }

  void addToCart() {
    try {
      stdout.write('상품의 이름을 입력해 주세요 ! : ');
      String? productName = stdin.readLineSync();
      stdout.write('상품의 개수를 입력해 주세요! : ');
      String? quantityInput = stdin.readLineSync();

      if (productName == null || quantityInput == null) {
        throw FormatException();
      }

      int? quantity = int.tryParse(quantityInput);
      if (quantity == null || quantity <= 0) {
        print(quantity == null
            ? '입력값이 올바르지 않아요 !'
            : '0개보다 많은 개수의 상품만 담을 수 있어요 !');
        return;
      }

      Product? product = products.firstWhere((p) => p.name == productName,
          orElse: () => Product('', 0));

      if (product.name.isEmpty) {
        print('입력값이 올바르지 않아요 !');
      } else {
        for (int i = 0; i < quantity; i++) {
          cart.add(product);
          totalPrice += product.price;
        }
        print('장바구니에 상품이 담겼어요 !');
      }
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
    }
  }

  void showTotal() {
    print('장바구니에 $totalPrice 원 어치를 담으셨네요 !');
  }
}

void main() {
  List<Product> productList = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  ShoppingMall mall = ShoppingMall(productList);
  bool isRunning = true;

  while (isRunning) {
    print(
        '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료');
    stdout.write('입력: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showTotal();
        break;
      case '4':
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        isRunning = false;
        break;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
