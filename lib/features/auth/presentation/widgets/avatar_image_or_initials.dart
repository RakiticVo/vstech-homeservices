import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Content of a round avatar: the `avatarUrl` photo from `GET /profiles` when there is one,
/// otherwise the user's initials. Place it inside the avatar's sized, circular container.
class AvatarImageOrInitials extends StatelessWidget {
  const AvatarImageOrInitials({required this.avatarUrl, required this.initials, required this.style, super.key});

  final String? avatarUrl;
  final String initials;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final fallback = Text(initials, style: style);
    final url = avatarUrl;
    if (url == null || url.isEmpty) return fallback;
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, _) => Center(child: fallback),
        errorWidget: (_, _, _) => Center(child: fallback),
      ),
    );
  }
}
