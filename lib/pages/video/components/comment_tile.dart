import 'package:flutter/material.dart';
import 'package:video_browser/models/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  final VoidCallback? onTap;
  const CommentTile(this.comment, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(comment.user.photoUrl),
              radius: 16,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  info(theme),
                  text(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget info(ThemeData theme) => Text(
        '${comment.user} • ${comment.dateAgo}',
        style: theme.textTheme.bodySmall,
      );

  Widget text(ThemeData theme) => Text(
        '$comment',
        maxLines: null,
      );
}
