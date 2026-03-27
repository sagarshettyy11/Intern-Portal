import 'package:flutter/material.dart';

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "approved":
      return Colors.green;
    case "pending":
      return Colors.blue;
    case "submitted":
      return Colors.orange;
    case "overdue":
      return Colors.red;
    default:
      return Colors.grey;
  }
}

Color getStatusBg(String status) {
  switch (status.toLowerCase()) {
    case "approved":
      return Color(0xFFEAF7EF);
    case "pending":
      return Color(0xFFEFF4FF);
    case "submitted":
      return Color(0xFFFFF8E6);
    case "overdue":
      return Color(0xFFFFF1F1);
    default:
      return Colors.grey.shade200;
  }
}
