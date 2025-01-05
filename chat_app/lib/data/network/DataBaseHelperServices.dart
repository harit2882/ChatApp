
abstract class DatabaseHelperServices{


  Future<int> insertData(Map<String, dynamic> row);
  // Database db = await instance.database;
  // return await db.insert('messages', row);

  Future<int> updateData(Map<String, dynamic> row);
  // Database db = await instance.database;
  // int id = row['id'];
  // return await db.update('messages', row, where: 'id = ?', whereArgs: [id]);

  Future<int> deleteData(int id);
  // Database db = await instance.database;
  // return await db.delete('messages', where: 'id = ?', whereArgs: [id]);

  dynamic getData();
// Database db = await instance.database;
// return await db.query('messages');

}