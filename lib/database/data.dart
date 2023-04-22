import 'package:umte_project/database/database.dart';

import '../data/enums/unit.dart';

List<Food> getFoodsData() {
  return const [
    Food(id: 1, name: 'Banana', description: "Banán v sobě obsahuje vitamíny skupiny B, vitamíny C a A. Najdeme v něm cenné minerální látky jako draslík, hořčík, vápník a fosfor.", calories: 0.940268928, fibre: 0.012, carbohydrates: 0.22, sugars: 0.19, fats: 0.002, unit: Unit.grams),
    Food(id: 2, name: 'Strawberries', description: "Jahody jsou bohatým zdrojem vitaminů C, B, E, železa a organických kyselin. Obsahují lehce stravitelnou rostlinnou vlákninu, z minerálních látek je zastoupen převážně draslík, zinek, hořčík, síra, vápník a některé netypické prvky jako je bor, fluor, kobalt či molybden. Jelikož tyto plody tvoří z 87% voda, tak jsou významným zdrojem tekutin.", calories: 0.34, fibre: 0.79, carbohydrates: 6.16, sugars: 4.29, fats: 0.37, unit: Unit.grams),
    Food(id: 3, name: 'Chia seeds', description: "Jahody jsou bohatým zdrojem vitaminů C, B, E, železa a organických kyselin. Obsahují lehce stravitelnou rostlinnou vlákninu, z minerálních látek je zastoupen převážně draslík, zinek, hořčík, síra, vápník a některé netypické prvky jako je bor, fluor, kobalt či molybden. Jelikož tyto plody tvoří z 87% voda, tak jsou významným zdrojem tekutin.", calories: 4.95, fibre: 0.212, carbohydrates: 0.2, sugars: 0.04, fats: 0.31, unit: Unit.grams),
    Food(id: 4, name: 'Oatmeal', description: "Ovesné vločky jsou z výživového hlediska komplexem složených sacharidů, rostlinných bílkovin i tuků (obsaženy jsou zejména nenasycené mastné kyseliny). Z vitamínů jsou zastoupeny zejména B1, B6 a vitamín E. Z minerálních látek můžeme jmenovat hlavně vápník a železo.", calories: 4.0, fibre: 0.07, carbohydrates: 0.68, sugars: 0.02, fats: 0.07, unit: Unit.grams),
    Food(id: 6, name: 'Red apple', description: "Jablko červené obsahuje řadu vitamínů, zejména vitamín C, a důležitou vlákninu. Nabízí nám také řadu minerálních látek a stopových prvků (draslík, hořčík, vápník, železo, fosfor, mangan).", calories: 0.73, fibre: 0.02, carbohydrates: 0.17, sugars: 0.12, fats: 0.0, unit: Unit.grams),
    Food(id: 7, name: 'Milk', description: "Mléko je dobrým zdrojem vápníku a obsahuje vitamíny A a D, i vitamíny skupiny B, zejména riboflavin. V mléce také najdete kvalitní bílkoviny a mléčný tuk.", calories: 0.47, fibre: null, carbohydrates: 0.17, sugars: 0.12, fats: 0.0, unit: Unit.grams),
    Food(id: 8, name: 'Milk Chocolate (Milka)', description: "Milka čokoláda mléčná (Alpine milk) obsahuje kakaové máslo, kakaovou hmotu, cukr, sušené odstředěné mléko, sójový lecitin a vanilkové aroma.", calories: 0.528528, fibre: 0.018, carbohydrates: 0.59, sugars: 0.59, fats: 0.29, unit: Unit.grams),
  ];
}