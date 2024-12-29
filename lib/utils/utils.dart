String getInitials(String name) {
  List<String> words = name.trim().split(' ');

  if (words.length >= 2) {
    return words[0][0].toUpperCase() + words[1][0].toUpperCase();
  } else if (words.length == 1) {
    return words[0][0].toUpperCase();
  } else {
    return '';
  }
}
