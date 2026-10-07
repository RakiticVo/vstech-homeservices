/// Strips the formatting users type into phone fields ("0901 234 567", "0901.234.567").
String normalizePhone(String input) => input.replaceAll(RegExp(r'[\s.\-()]'), '');
