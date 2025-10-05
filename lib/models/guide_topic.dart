class CourseLink {
  final String title;
  final String url;

  CourseLink({required this.title, required this.url});
}

class GuideTopic {
  final String title;
  final String link;
  final String description;
  final List<CourseLink> courses; 

  GuideTopic({
    required this.title,
    required this.link,
    this.description = '',
    required this.courses,
  });
}