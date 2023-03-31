enum TypeOfMeal {
  breakfast,
  brunch,
  lunch,
  snack,
  dinner,
  lateDinner;

  String getName() {

    switch(this) {
      case TypeOfMeal.breakfast: return "Breakfast";
      case TypeOfMeal.brunch: return "Brunch";
      case TypeOfMeal.lunch: return "Lunch";
      case TypeOfMeal.snack: return "Afternoon Snack";
      case TypeOfMeal.dinner: return "Dinner";
      case TypeOfMeal.lateDinner: return "Late dinner";
      default: return "NOT_RECOGNIZED";
    }

  }
}