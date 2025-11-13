Map<String, dynamic> addActivities({
  required String name,
  required int colorId,
}) {
  return {
    "Name": name,
    "Color": colorId, // назначаем индекс цвета
  };
}
