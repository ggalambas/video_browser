import 'package:flutter/material.dart';
import 'package:video_browser/config/constants.dart';
import 'package:video_browser/models/video.dart';

class InfoSection extends StatelessWidget {
  final Video video;
  final bool expanded;
  final VoidCallback? onTap;
  const InfoSection(this.video, {super.key, this.expanded = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding)
                .add(const EdgeInsets.only(top: 12, bottom: 8)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(context),
                          const SizedBox(height: 4),
                          info(context),
                        ],
                      ),
                    ),
                    expanded
                        ? const Icon(Icons.expand_less_outlined)
                        : const Icon(Icons.expand_more_outlined),
                  ],
                ),
                const SizedBox(height: 8),
                if (!expanded)
                  SizedBox(
                    height: kChipHeight,
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(width: 4),
                      scrollDirection: Axis.horizontal,
                      itemCount: video.tags.length,
                      itemBuilder: (_, i) => tagChip(context, video.tags[i]),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (expanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding)
                .add(const EdgeInsets.only(top: 10, bottom: kPagePadding * 2)),
            child: Column(
              children: [
                Text(video.description),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    for (final tag in video.tags) tagChip(context, tag)
                  ],
                ),
                const SizedBox(height: 32),
                Center(child: avatar),
                const SizedBox(height: 8),
                Center(child: coachName(context)),
              ],
            ),
          ),
      ],
    );
  }

  Widget title(BuildContext context) => Text(
        video.title,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(fontSize: kTitleSize),
        maxLines: null,
      );

  Widget info(BuildContext context) => Text(
        '${video.coach} • ${video.sport} • ${video.uploadDateAgo}',
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: null,
      );

  Widget tagChip(BuildContext context, String tag) => ActionChip(
      visualDensity: VisualDensity.compact,
      shape: const StadiumBorder(side: BorderSide(color: Colors.white24)),
      backgroundColor: Colors.transparent,
      label: Text(tag),
      onPressed: () {} // TODO Search tag
      );

  Widget get avatar => CircleAvatar(
        backgroundImage: AssetImage(video.coach.photoUrl),
      );

  Text coachName(BuildContext context) => Text(
        video.coach.name.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall,
      );
}
