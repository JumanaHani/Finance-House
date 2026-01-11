import '../../domain/entities/user.dart';

class UserModel {
  final double balance;
  final bool isVerified;
  final double monthlyTotalTopUp;

  UserModel({
    required this.balance,
    required this.isVerified,
    required this.monthlyTotalTopUp,
  });

  User toEntity() {
    return User(
      balance: balance,
      isVerified: isVerified,
      monthlyTotalTopUp: monthlyTotalTopUp,
    );
  }

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      balance: entity.balance,
      isVerified: entity.isVerified,
      monthlyTotalTopUp: entity.monthlyTotalTopUp,
    );
  }
}
