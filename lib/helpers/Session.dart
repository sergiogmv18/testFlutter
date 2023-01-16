class Session {
  Map<String, dynamic> _data = {};

  /*
   * set value
   * @author BSB
   * @version 2021-04-26 initial release
   * @param <String> key
   * @param <dynamic> value
   * @return void
   */
  void setValue(String key, dynamic value) {
    _data[key] = value;
  }

  /*
   * get value
   * @author BSB
   * @version 2021-04-26 initial release
   * @param <String> key
   * @return dynamic
   */
  dynamic getValue(String key) {
    if (_data.containsKey(key)) {
      return _data[key];
    }
    return null;
  }

  /*
   * remove
   * @author BSB
   * @version 2021-04-26 initial release
   * @param <String> key
   * @return void
   */
  void remove(String key) {
    if (_data.containsKey(key)) {
      _data.remove(key);
    }
  }

  /*
   * get all
   * @author BSB
   * @version 2021-04-26 initial release
   * @return Map<String, dynamic>
   */
  Map<String, dynamic> getAll() {
    return _data;
  }

  /*
   * clear session
   * @author BSB
   * @version 2021-04-26 initial release
   * @return void
   */
  void clear() {
    _data.clear();
  }
}
