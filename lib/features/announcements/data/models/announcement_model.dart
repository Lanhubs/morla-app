class AnnouncementModel {
  final String id;
  final String announcementId;
  final String title;
  final String message;
  final String type;
  final String priority;
  final bool ctaEnabled;
  final String? ctaButtonText;
  final String? ctaDeepLink;
  final bool read;
  final DateTime? readAt;
  final DateTime createdAt;

  AnnouncementModel({
    required this.id,
    required this.announcementId,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    required this.ctaEnabled,
    this.ctaButtonText,
    this.ctaDeepLink,
    required this.read,
    this.readAt,
    required this.createdAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] ?? '',
      announcementId: json['announcement_id'] ?? json['id'] ?? '',
      title: json['announcement_title'] ?? json['title'] ?? '',
      message: json['announcement_message'] ?? json['message'] ?? '',
      type: json['announcement_type'] ?? json['type'] ?? '',
      priority: json['announcement_priority'] ?? json['priority'] ?? 'routine',
      ctaEnabled:
          json['announcement_cta_enabled'] ?? json['ctaEnabled'] ?? false,
      ctaButtonText:
          json['announcement_cta_button_text'] ?? json['ctaButtonText'],
      ctaDeepLink: json['announcement_cta_deep_link'] ?? json['ctaDeepLink'],
      read: json['read'] ?? false,
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'announcement_id': announcementId,
      'title': title,
      'message': message,
      'type': type,
      'priority': priority,
      'ctaEnabled': ctaEnabled,
      'ctaButtonText': ctaButtonText,
      'ctaDeepLink': ctaDeepLink,
      'read': read,
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  AnnouncementModel copyWith({
    String? id,
    String? announcementId,
    String? title,
    String? message,
    String? type,
    String? priority,
    bool? ctaEnabled,
    String? ctaButtonText,
    String? ctaDeepLink,
    bool? read,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return AnnouncementModel(
      id: id ?? this.id,
      announcementId: announcementId ?? this.announcementId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      ctaEnabled: ctaEnabled ?? this.ctaEnabled,
      ctaButtonText: ctaButtonText ?? this.ctaButtonText,
      ctaDeepLink: ctaDeepLink ?? this.ctaDeepLink,
      read: read ?? this.read,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
