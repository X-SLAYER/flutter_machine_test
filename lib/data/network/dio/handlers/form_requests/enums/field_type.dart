enum FieldType {
  text,
  date,
  dropDown;

  int get value => switch (this) {
    text => 1,
    date => 11,
    dropDown => 4,
  };
}
