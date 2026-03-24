abstract class BaseModel {
  /// 插入数据库字段
  Map<String, dynamic> toSqlMap();

  BaseModel();
}

enum PickStore {
  /// 存货区
  store,

  /// 拣货区
  pick,
}

