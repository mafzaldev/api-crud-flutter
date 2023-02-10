class Service {
  final String id;
  final String title;
  final String description;
  final String status;

  const Service({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  static Service fromJson(json) => Service(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        status: json['status'],
      );
}
