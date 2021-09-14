// Fonction qui prend en paramètre le poids du package pour pouvoir faire un text adapté.


String weight(double poids) {
  String weight = "";

  if (poids < 0.5) {
    weight = "0-500 g";
  } else if (poids < 1) {
    weight = "500 g - 1kg";
  } else {
    weight = "+ 1 kg";
  }

  return weight;
}