import 'package:flutter/foundation.dart';

import 'package:test_coda/client/models/client.dart';
import 'package:test_coda/client/models/links.dart';

@immutable
class ClientListResponse {
  const ClientListResponse({
    this.currentPage,
    required this.clients,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ClientListResponse.fromMap(Map<String, dynamic> map) {
    return ClientListResponse(
      currentPage: map['current_page'] as num?,
      clients: (map['data'] as List)
          .cast<Map<dynamic, dynamic>>()
          .map((client) => client.cast<String, dynamic>())
          .map(Client.fromMap)
          .toList(),
      firstPageUrl: map['first_page_url'] as String?,
      from: map['from'] as num?,
      lastPageUrl: map['last_page_url'] as String?,
      links: (map['links'] as List)
          .cast<Map<dynamic, dynamic>>()
          .map((link) => link.cast<String, dynamic>())
          .map(Link.fromMap)
          .toList(),
      nextPageUrl: map['next_page_url'] as String?,
      path: map['path'] as String?,
      perPage: map['per_page'] as num?,
      prevPageUrl: map['prev_page_url'] as String?,
      to: map['to'] as num?,
      total: map['total'] as num?,
    );
  }

  final num? currentPage;
  final List<Client> clients;
  final String? firstPageUrl;
  final num? from;
  final num? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String? path;
  final num? perPage;
  final String? prevPageUrl;
  final num? to;
  final num? total;

  ClientListResponse copyWith({
    num? currentPage,
    List<Client>? clients,
    String? firstPageUrl,
    num? from,
    num? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    String? nextPageUrl,
    String? path,
    num? perPage,
    String? prevPageUrl,
    num? to,
    num? total,
  }) {
    return ClientListResponse(
      currentPage: currentPage ?? this.currentPage,
      clients: clients ?? this.clients,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentPage': currentPage,
      'clients': clients.map((x) => x.toMap()).toList(),
      'firstPageUrl': firstPageUrl,
      'from': from,
      'lastPageUrl': lastPageUrl,
      'links': links.map((x) => x.toMap()).toList(),
      'nextPageUrl': nextPageUrl,
      'path': path,
      'perPage': perPage,
      'prevPageUrl': prevPageUrl,
      'to': to,
      'total': total,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClientListResponse &&
        other.currentPage == currentPage &&
        listEquals(other.clients, clients) &&
        other.firstPageUrl == firstPageUrl &&
        other.from == from &&
        other.lastPageUrl == lastPageUrl &&
        listEquals(other.links, links) &&
        other.nextPageUrl == nextPageUrl &&
        other.path == path &&
        other.perPage == perPage &&
        other.prevPageUrl == prevPageUrl &&
        other.to == to &&
        other.total == total;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        clients.hashCode ^
        firstPageUrl.hashCode ^
        from.hashCode ^
        lastPageUrl.hashCode ^
        links.hashCode ^
        nextPageUrl.hashCode ^
        path.hashCode ^
        perPage.hashCode ^
        prevPageUrl.hashCode ^
        to.hashCode ^
        total.hashCode;
  }
}
