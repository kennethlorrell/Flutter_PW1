class FuelCompositionResult {
  final Map<String, double> workingMassComposition;
  final double dryMassCoefficient;
  final double combustibleMassCoefficient;
  final Map<String, double> dryMassComposition;
  final Map<String, double> combustibleMassComposition;
  final double lowerHeatWorking;
  final double lowerHeatDry;
  final double lowerHeatCombustible;

  FuelCompositionResult({
    required this.workingMassComposition,
    required this.dryMassCoefficient,
    required this.combustibleMassCoefficient,
    required this.dryMassComposition,
    required this.combustibleMassComposition,
    required this.lowerHeatWorking,
    required this.lowerHeatDry,
    required this.lowerHeatCombustible,
  });
}
