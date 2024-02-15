class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime; // Nullable DateTime
  bool? isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    this.dateTime, // Nullable DateTime
    this.isDone = false,
  });

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
    id: data['id'],
    title: data['title'],
    description: data['description'],
    dateTime: data['dateTime'] != null
        ? DateTime.fromMicrosecondsSinceEpoch(data['dateTime'])
        : null, // Handle nullable value
    isDone: data['isDone'],
  );

  Map<String, dynamic> toFiresStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch, // Nullable DateTime
      'isDone': isDone,
    };
  }
}
