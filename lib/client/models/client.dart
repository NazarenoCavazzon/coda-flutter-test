import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class Client {
  const Client({
    required this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.photo,
    this.caption,
    this.createdAt,
    this.uploadedAt,
    this.deleted,
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] as num?,
      firstname: map['firstname'] as String?,
      lastname: map['lastname'] as String?,
      email: map['email'] as String?,
      address: map['address'] as String?,
      photo: map['photo'] as String?,
      caption: map['caption'] as String?,
      createdAt: map['createdAt'] as String?,
      uploadedAt: map['uploadedAt'] as String?,
      deleted: map['deleted'] as num?,
    );
  }

  final num? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? address;
  final String? photo;
  final String? caption;
  final String? createdAt;
  final String? uploadedAt;
  final num? deleted;

  Client copyWith({
    num? id,
    String? firstname,
    String? lastname,
    String? email,
    String? address,
    String? photo,
    String? caption,
    String? createdAt,
    String? uploadedAt,
    num? deleted,
  }) {
    return Client(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      caption: caption ?? this.caption,
      createdAt: createdAt ?? this.createdAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'address': address,
      'photo': photo,
      'caption': caption,
      'createdAt': createdAt,
      'uploadedAt': uploadedAt,
      'deleted': deleted,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Client &&
        other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.address == address &&
        other.photo == photo &&
        other.caption == caption &&
        other.createdAt == createdAt &&
        other.uploadedAt == uploadedAt &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        address.hashCode ^
        photo.hashCode ^
        caption.hashCode ^
        createdAt.hashCode ^
        uploadedAt.hashCode ^
        deleted.hashCode;
  }
}
