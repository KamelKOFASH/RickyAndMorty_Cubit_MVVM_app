class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  // Factory constructor to create an Info object from JSON
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }
}

class LocationModel {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final DateTime created;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  // Factory constructor to create a Location object from JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      dimension: json['dimension'] as String,
      residents: List<String>.from(json['residents']),
      url: json['url'] as String,
      created: DateTime.parse(json['created']),
    );
  }
}

class LocationsResponse {
  final Info info;
  final List<LocationModel> results;

  LocationsResponse({
    required this.info,
    required this.results,
  });

  // Factory constructor to create a LocationsResponse object from JSON
  factory LocationsResponse.fromJson(Map<String, dynamic> json) {
    return LocationsResponse(
      info: Info.fromJson(json['info']),
      results: (json['results'] as List)
          .map((location) => LocationModel.fromJson(location))
          .toList(),
    );
  }
}
