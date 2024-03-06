class Ayat {
  String? arabic;
  String? julioCortes;
  String? raulGonzalezBornez;
  String? muhammadIsaGarcia;

  Ayat({
    this.arabic,
    this.julioCortes,
    this.raulGonzalezBornez,
    this.muhammadIsaGarcia,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        arabic: json['arabic'] as String?,
        julioCortes: json['julio_cortes'] as String?,
        raulGonzalezBornez: json['raul_gonzalez_bornez'] as String?,
        muhammadIsaGarcia: json['muhammad_isa_garcia'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'arabic': arabic,
        'julio_cortes': julioCortes,
        'raul_gonzalez_bornez': raulGonzalezBornez,
        'muhammad_isa_garcia': muhammadIsaGarcia,
      };
}
