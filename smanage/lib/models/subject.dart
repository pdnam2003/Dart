class Subject {
  final String code;
  String name;
  int credits;
  Subject({
    required this.code,
    required this.name,
    required this.credits,
  });
 @override
  String toString() {
    return '$name (Mã: $code - $credits tín chỉ)';
  }
}
