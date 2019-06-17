
/// used to translate a, in general, api [error]
/// to a user friendly information
String parseErrorToMessage(dynamic error) =>
  error.toString();

/// use the [hour] to return a salutation
String parseHourToSalutation(int hour) {
  if (hour < 12) {
    return 'Good morning';
  } else if (hour < 18) {
    return 'Good afternoon';
  } else if (hour <= 23) {
    return 'Good evening';
  }
  return 'Hello';
}

/// format [rating] as X.XX
String parseRating(double rating) =>
  rating.toStringAsPrecision(3);
