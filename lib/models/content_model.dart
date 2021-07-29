import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Content {
  final String name;
  final String imageUrl;
  final String videoUrl;
  final String description;
  final String id;
  final int? views;
  // final Color color;

  const Content({
    required this.name,
    required this.imageUrl,
    required this.videoUrl,
    required this.description,
    required this.id,
    this.views
    // this.color,
  });
}
