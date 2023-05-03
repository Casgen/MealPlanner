enum Unit {
  grams,
  millilitre,
  times,
  pieces;
  
  String getSymbol() {
    switch (this) {
      case Unit.grams: return 'g';
      case Unit.times: return 'times';
      case Unit.millilitre: return 'ml';
      case Unit.pieces: return 'pc';
      default: return "NOT_KNOWN";
    }
  }
}