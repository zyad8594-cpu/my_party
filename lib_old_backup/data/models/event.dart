class Event {
  final int id;
  final int clientId;
  final int coordinatorId;
  final String nameEvent;
  final String? description;
  final String eventDate;
  final String? location;
  final double? budget;
  final String? status;
  final String? createdAt;
  String? clientName;
  String? coordinatorName;

  Event({
    required this.id,
    required this.clientId,
    required this.coordinatorId,
    required this.nameEvent,
    required this.eventDate,
    this.description,
    this.location,
    this.budget,
    this.status,
    this.createdAt,
    this.clientName,
    this.coordinatorName,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['event_id'] ?? json['id'] ?? 0,
      clientId: json['client_id'] ?? 0,
      coordinatorId: json['coordinator_id'] ?? 0,
      nameEvent: json['name_event'] ?? '',
      description: json['description'],
      eventDate: json['event_date'] ?? '',
      location: json['location'],
      budget: json['budget']?.toDouble(),
      status: json['status'],
      createdAt: json['created_at'],
      clientName: json['client_name'],
      coordinatorName: json['coordinator_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'coordinator_id': coordinatorId,
      'name_event': nameEvent,
      'description': description,
      'event_date': eventDate,
      'location': location,
      'budget': budget,
      'status': status,
    };
  }
}