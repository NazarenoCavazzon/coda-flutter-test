import 'package:flutter/material.dart';

@immutable
class Link {
  const Link({
    this.url,
    this.label,
    required this.active,
  });

  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
      url: map['url'] as String?,
      label: map['label'] as String?,
      active: (map['active'] as bool?) ?? false,
    );
  }

  final String? url;
  final String? label;
  final bool? active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return Link(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Link &&
        other.url == url &&
        other.label == label &&
        other.active == active;
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;
}
