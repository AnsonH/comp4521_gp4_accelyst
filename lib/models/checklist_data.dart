/// Represents an item in a photo grid.
class ChecklistData {
  final String id;
  String checklistName;
  bool checked = false;

  ChecklistData({
    required this.id,
    required this.checklistName,
  });
}
