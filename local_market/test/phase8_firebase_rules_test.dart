import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/core/services/firebase_auth_service.dart';
import 'package:local_market/models/user_model.dart';

void main() {
  test('UserModel correctly parses buyer and seller roles', () {
    final buyer = UserModel(
      uid: 'user_buyer_1',
      name: 'Rahim Buyer',
      email: 'buyer@localmarket.com',
      role: UserRole.buyer,
      createdAt: DateTime.now(),
    );

    final seller = UserModel(
      uid: 'user_seller_1',
      name: 'Rahman Shopkeeper',
      email: 'seller@localmarket.com',
      role: UserRole.seller,
      createdAt: DateTime.now(),
    );

    expect(buyer.isBuyer, isTrue);
    expect(buyer.isSeller, isFalse);

    expect(seller.isSeller, isTrue);
    expect(seller.isBuyer, isFalse);

    final buyerMap = buyer.toMap();
    expect(buyerMap['role'], 'buyer');

    final parsedSeller = UserModel.fromMap(seller.toMap());
    expect(parsedSeller.role, UserRole.seller);
  });

  test(
    'FirebaseAuthService provides safe fallback when uninitialized',
    () async {
      final authService = FirebaseAuthService();
      expect(authService.currentUser, isNull);

      final profile = await authService.getUserProfile('non_existent_id');
      expect(profile, isNull);

      final signedIn = await authService.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );
      expect(signedIn, isNull);
    },
  );
}
