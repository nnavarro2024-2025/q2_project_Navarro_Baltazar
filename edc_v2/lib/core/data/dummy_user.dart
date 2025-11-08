import 'package:edc_v2/features/auth/domain/entity/user_entity.dart';

// Dummy user for web testing when authentication is not available
final dummyUser = UserEntity(
  id: 'dummy_user_id',
  email: 'nnavarro_230000002875@gmail.com',
  displayName: 'Nikko Angelo Navarro',
  photoURL: 'https://ui-avatars.com/api/?name=Nikko+Angelo+Navarro',
  totalDonated: 15000000,       // Total money donated in PHP (150,000.00 PHP)
  totalDonateddevice: 8,        // Total number of devices donated
  projectsSupported: 5,         // Number of projects/organizations supported
);