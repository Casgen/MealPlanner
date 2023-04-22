enum Unit {
  grams,
  millilitre;
  
  String getSymbol() {
    switch (this) {
      case Unit.grams: return 'g';
      case Unit.millilitre: return 'ml';
      default: return "NOT_KNOWN";
    }
  }
}