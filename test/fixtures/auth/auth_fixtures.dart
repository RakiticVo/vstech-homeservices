import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';

const customerUser = AppUser(id: 9, role: UserRole.customer, fullName: 'Nguyễn Thị Mai');

const workerUser = AppUser(id: 8821, role: UserRole.worker, fullName: 'Trần Văn Hùng');

const customerProfile = UserProfile(
  id: 9,
  role: UserRole.customer,
  fullName: 'Nguyễn Thị Mai',
  email: 'maingvyen@gmail.com',
  phoneNumber: '0901 234 567',
  defaultAddress: '123 Nguyễn Thị Minh Khai, Phường Bến Thành, Quận 1',
);

const workerProfile = UserProfile(
  id: 8821,
  role: UserRole.worker,
  fullName: 'Trần Văn Hùng',
  phoneNumber: '0909 123 456',
  rating: 4.9,
);
