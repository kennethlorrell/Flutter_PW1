import '../models/fuel_composition_result.dart';

// Розрахунок коефіцієнта сухої маси на основі вмісту вологи
double calculateDryMassCoefficient(double waterContent) {
  return 100 / (100 - waterContent);
}

// Розрахунок коефіцієнта горючої маси на основі вмісту вологи та золи
double calculateCombustibleMassCoefficient(double waterContent, double ashContent) {
  return 100 / (100 - waterContent - ashContent);
}

// Розрахунок складу сухої маси для заданого компонента та коефіцієнта сухої маси
double calculateDryMassComposition(double componentPercentage, double dryMassCoefficient) {
  return componentPercentage * dryMassCoefficient;
}

// Розрахунок складу горючої маси для заданого компонента та коефіцієнта горючої маси
double calculateCombustibleMassComposition(double componentPercentage, double combustibleMassCoefficient) {
  return componentPercentage * combustibleMassCoefficient;
}

// Розрахунок нижчої теплоти згоряння робочої маси палива
double calculateLowerHeatOfCombustion(
    double hydrogen,
    double carbon,
    double oxygen,
    double sulfur,
    double moisture,
    ) {
  return (339 * carbon + 1030 * hydrogen - 108.8 * (oxygen - sulfur) - 25 * moisture) / 1000;
}

// Розрахунок теплоти згоряння сухої маси на основі теплоти згоряння робочої маси
double calculateHeatForDryMass(double workingHeat, double moisture) {
  return (workingHeat + 0.025 * moisture) * (100 / (100 - moisture));
}

// Розрахунок теплоти згоряння горючої маси на основі теплоти згоряння робочої маси
double calculateHeatForCombustibleMass(double workingHeat, double moisture, double ash) {
  return (workingHeat + 0.025 * moisture) * (100 / (100 - moisture - ash));
}

// Основний розрахунок властивостей палива
FuelCompositionResult calculateFuelProperties(
    double hydrogen,
    double carbon,
    double sulfur,
    double nitrogen,
    double oxygen,
    double moisture,
    double ash,
    ) {
  // Робочий склад маси (первинні дані)
  Map<String, double> workingMassComposition = {
    "H": hydrogen,
    "C": carbon,
    "S": sulfur,
    "N": nitrogen,
    "O": oxygen,
    "M": moisture,
    "A": ash,
  };

  // Розрахунок коефіцієнтів
  double dryMassCoefficient = calculateDryMassCoefficient(moisture);
  double combustibleMassCoefficient = calculateCombustibleMassCoefficient(moisture, ash);

  // Склад сухої маси
  Map<String, double> dryMassComposition = {
    "H": calculateDryMassComposition(hydrogen, dryMassCoefficient),
    "C": calculateDryMassComposition(carbon, dryMassCoefficient),
    "S": calculateDryMassComposition(sulfur, dryMassCoefficient),
    "N": calculateDryMassComposition(nitrogen, dryMassCoefficient),
    "O": calculateDryMassComposition(oxygen, dryMassCoefficient),
    "A": calculateDryMassComposition(ash, dryMassCoefficient),
  };

  // Склад горючої маси
  Map<String, double> combustibleMassComposition = {
    "H": calculateCombustibleMassComposition(hydrogen, combustibleMassCoefficient),
    "C": calculateCombustibleMassComposition(carbon, combustibleMassCoefficient),
    "S": calculateCombustibleMassComposition(sulfur, combustibleMassCoefficient),
    "N": calculateCombustibleMassComposition(nitrogen, combustibleMassCoefficient),
    "O": calculateCombustibleMassComposition(oxygen, combustibleMassCoefficient),
  };

  // Теплота згоряння для різних типів маси
  double lowerHeatWorking = calculateLowerHeatOfCombustion(hydrogen, carbon, oxygen, sulfur, moisture);
  double lowerHeatDry = calculateHeatForDryMass(lowerHeatWorking, moisture);
  double lowerHeatCombustible = calculateHeatForCombustibleMass(lowerHeatWorking, moisture, ash);

  return FuelCompositionResult(
    workingMassComposition: workingMassComposition,
    dryMassCoefficient: dryMassCoefficient,
    combustibleMassCoefficient: combustibleMassCoefficient,
    dryMassComposition: dryMassComposition,
    combustibleMassComposition: combustibleMassComposition,
    lowerHeatWorking: lowerHeatWorking,
    lowerHeatDry: lowerHeatDry,
    lowerHeatCombustible: lowerHeatCombustible,
  );
}

// Розрахунок складу мазуту для робочої маси
Map<String, dynamic> recalculateFuelOilComposition(
    double carbon,
    double hydrogen,
    double oxygen,
    double sulfur,
    double lowerHeatCombustible,
    double moisture,
    double ash,
    double vanadium,
    ) {
  double conversionFactor = (100 - moisture - ash) / 100;

  // Розрахунок компонентів для робочої маси
  double carbonWorking = carbon * conversionFactor;
  double hydrogenWorking = hydrogen * conversionFactor;
  double oxygenWorking = oxygen * conversionFactor;
  double sulfurWorking = sulfur * conversionFactor;
  double ashWorking = ash * conversionFactor;
  double vanadiumWorking = vanadium * (100 - moisture) / 100;
  double lowerHeatWorking = lowerHeatCombustible * conversionFactor - (0.025 * moisture);

  return {
    "C": carbonWorking,
    "H": hydrogenWorking,
    "O": oxygenWorking,
    "S": sulfurWorking,
    "A": ashWorking,
    "V": vanadiumWorking,
    "LowerHeatWorking": lowerHeatWorking,
  };
}
