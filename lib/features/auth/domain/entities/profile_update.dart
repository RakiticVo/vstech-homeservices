/// Fields a screen wants to change on the profile. Null means "leave unchanged".
class ProfileUpdate {
  const ProfileUpdate({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.defaultAddress,
    this.lat,
    this.lng,
  });

  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? defaultAddress;
  final double? lat;
  final double? lng;
}
