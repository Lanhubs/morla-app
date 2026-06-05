/// Utility functions for formatting client data
class FormatUtils {
  /// Format currency value with commas
  static String formatCurrency(double value) {
    final parts = value.toStringAsFixed(0).split('.');
    final clean = parts[0];
    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = clean.replaceAllMapped(regex, (Match m) => '${m[1]},');
    return '\$$formatted';
  }

  /// Get initials from name
  static String getInitials(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return '??';

    final parts = trimmedName.split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    return parts.take(2).map((e) => e[0]).join('').toUpperCase();
  }

  /// Format date to readable string
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
