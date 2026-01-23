class Course {
  final int courseNumber;
  final String variantId;
  final String variantName;
  final Map<String, String> stopTimes;

  Course({
    required this.courseNumber,
    required this.variantId,
    required this.variantName,
    required this.stopTimes,
  });

  Course copyWith({
    int? courseNumber,
    String? variantId,
    String? variantName,
    Map<String, String>? stopTimes,
  }) {
    return Course(
      courseNumber: courseNumber ?? this.courseNumber,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
      stopTimes: stopTimes ?? this.stopTimes,
    );
  }
}
