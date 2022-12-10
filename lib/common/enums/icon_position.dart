enum IconPosition {
  start,
  end,
}

extension IconPositionExtensions on IconPosition {
  get isStart => this == IconPosition.start;
  get isEnd => this == IconPosition.end;
}
