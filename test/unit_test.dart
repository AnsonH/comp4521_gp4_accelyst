import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/models/todo/todo_item.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Test Case 1: MnemonicsData.appendNewMnemonic()', () {
    /// Define new variables
    final testMnemonicMaterial = MnemonicMaterial(
        type: MnemonicType.romanRoom,
        title: "Test Material",
        uuid: const Uuid().v4());

    final testSubjectMaterialsData =
        SubjectMaterialsData(subjectName: "English", materials: []);

    final testMnemonicsData = MnemonicsData([testSubjectMaterialsData]);

    /// Run the function
    testMnemonicsData.appendNewMnemonic(
        subject: "English", material: testMnemonicMaterial);

    /// Compare the expected and actual results
    expect(testMnemonicsData.subjectMaterials[0].subjectName, "English");
    expect(testMnemonicsData.subjectMaterials[0].materials[0].title,
        "Test Material");
    expect(testMnemonicsData.subjectMaterials[0].materials[0].type,
        MnemonicType.romanRoom);
  });

  test('Test Case 2: MnemonicsData.updateMaterial()', () {
    /// Define new variables
    String id = const Uuid().v4();

    final testMnemonicMaterial = MnemonicMaterial(
        type: MnemonicType.romanRoom, title: "Test Material", uuid: id);

    final testSubjectMaterialsData = SubjectMaterialsData(
        subjectName: "English", materials: [testMnemonicMaterial]);

    final testMnemonicsData = MnemonicsData([testSubjectMaterialsData]);

    /// Run the function
    testMnemonicsData.updateMaterial(
        uuid: id, newSubject: "Chinese", newTitle: "New Test Material");

    /// Compare the expected and actual results
    expect(testMnemonicsData.subjectMaterials[0].subjectName, "Chinese");
    expect(testMnemonicsData.subjectMaterials[0].materials[0].title,
        "New Test Material");
  });

  test('Test Case 3: MnemonicsData.searchMaterialByUUID()', () {
    /// Define new variables
    String id = const Uuid().v4();

    final testMnemonicMaterial = MnemonicMaterial(
        type: MnemonicType.romanRoom, title: "Test Material", uuid: id);

    final testSubjectMaterialsData1 =
        SubjectMaterialsData(subjectName: "Chinese", materials: []);

    final testSubjectMaterialsData2 = SubjectMaterialsData(
        subjectName: "English", materials: [testMnemonicMaterial]);

    final testMnemonicsData =
        MnemonicsData([testSubjectMaterialsData1, testSubjectMaterialsData2]);

    /// Run the function
    List<int> result = testMnemonicsData.searchMaterialByUUID(id);

    /// Compare the expected and actual results
    expect(result[0], 1);
    expect(result[1], 0);
  });

  test('Test Case 4: MnemonicsData.deleteMaterial()', () {
    /// Define new variables
    String id1 = const Uuid().v4();
    String id2 = const Uuid().v4();

    final testMnemonicMaterial1 = MnemonicMaterial(
        type: MnemonicType.romanRoom, title: "Test Material", uuid: id1);

    final testMnemonicMaterial2 = MnemonicMaterial(
        type: MnemonicType.romanRoom, title: "Test Material", uuid: id2);

    final testSubjectMaterialsData = SubjectMaterialsData(
        subjectName: "English",
        materials: [testMnemonicMaterial1, testMnemonicMaterial2]);

    final testMnemonicsData = MnemonicsData([testSubjectMaterialsData]);

    /// Run the function
    testMnemonicsData.deleteMaterial(id1);

    /// Compare the expected and actual results
    expect(testMnemonicsData.subjectMaterials[0].materials.length, 1);

    /// Run the function
    testMnemonicsData.deleteMaterial(id2);

    /// Compare the expected and actual results
    expect(testMnemonicsData.subjectMaterials.length, 0);
  });

  test('Test Case 5: RomanRoom.getItemIndex()', () {
    /// Define new variables
    String item1_id = const Uuid().v4();
    String item2_id = const Uuid().v4();
    String room_id = const Uuid().v4();

    final testRomanRoomItem1 = RomanRoomItem(
      id: item1_id,
      description: "",
      imageFile: null,
      url: null,
    );

    final testRomanRoomItem2 = RomanRoomItem(
      id: item2_id,
      description: "",
      imageFile: null,
      url: null,
    );

    final testRomanRoom = RomanRoom(
        id: room_id,
        items: [testRomanRoomItem1, testRomanRoomItem2],
        name: "testRomanRoom",
        subject: "Math",
        description: "");

    /// Run the function
    int result = testRomanRoom.getItemIndex(item2_id);

    /// Compare the expected and actual results
    expect(result, 1);
  });

  test('Test Case 6: TodoItem.isOverdue()', () {
    /// Define new variables
    String id = const Uuid().v4();
    TodoItem testTodoItem = TodoItem(
        id: id,
        name: "Todo Item",
        category: "",
        priority: TodoPriority.high,
        description: "",
        deadline: DateTime(2023, 3, 18, 0, 0, 0),
        subtasks: []);

    /// Run the function
    bool result = testTodoItem.isOverdue();

    /// Compare the expected and actual results
    expect(result, false);

    /// Run the function
    testTodoItem.deadline = DateTime(2022, 5, 18, 0, 0, 0);
    bool result_2 = testTodoItem.isOverdue();

    /// Compare the expected and actual results
    print(DateFormat("MMM dd H:m").format(testTodoItem.deadline!));
    expect(result_2, true);

    /// Run the function
    String output = DateFormat("MMM dd H:m").format(testTodoItem.deadline!);

    /// Compare the expected and actual results
    expect(output,
        DateFormat("MMM dd H:m").format(DateTime(2022, 5, 18, 0, 0, 0)));
  });
}
