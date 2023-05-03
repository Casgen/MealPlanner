enum Unit {
  grams,
  millilitre,
  pieces;
  
  String getSymbol() {
    switch (this) {
      case Unit.grams: return 'g';
      case Unit.millilitre: return 'ml';
      case Unit.pieces: return 'pc';
      default: return "NOT_KNOWN";
    }
  }
}