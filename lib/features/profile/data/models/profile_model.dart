class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imagePath;

  const ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imagePath,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? imagePath,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}