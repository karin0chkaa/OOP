abstract class CBody {
  double getDensity();

  double getVolume();

  double getMass() {
    return getDensity() * getVolume();
  }

  double getWeightInWater() {
    const double waterDensity = 1000;
    const double gravity = 9.81;

    return (getMass() - waterDensity * getVolume()) * gravity;
  }

  String toString();
}
