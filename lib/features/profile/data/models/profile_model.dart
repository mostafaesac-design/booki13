class ProfileModel {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imagePath;

  const ProfileModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imagePath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}'),
    name: json['name']?.toString() ?? '',
    email: json['email']?.toString() ?? '',
    phone: json['phone']?.toString() ?? '',
    address: json['address']?.toString() ?? '',
    imagePath: json['image']?.toString() ?? '',
  );

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? imagePath,
  }) {
    return ProfileModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
