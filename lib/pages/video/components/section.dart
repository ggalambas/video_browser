enum Section {
  info,
  comments,
  relatedVideos;

  bool get isInfo => this == Section.info;
  bool get isComments => this == Section.comments;
  bool get isRelatedVideos => this == Section.relatedVideos;
}
