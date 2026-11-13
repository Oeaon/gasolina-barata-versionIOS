/// Datos propios de esta app: nombre, web, textos legales y fuentes oficiales.
class AppInfo {
  AppInfo._();

  static const name = 'Gasolina Barata';
  static const privacyUrl = 'https://oeaon.github.io/gasolina-barata/privacy.html';
  static const termsUrl = 'https://oeaon.github.io/gasolina-barata/terms.html';

  /// Fuentes oficiales que se enlazan en Ajustes (lo exigen las tiendas para información de organismos públicos).
  static const officialSources = [
    'https://geoportalgasolineras.es/geoportal-instalaciones/Inicio',
    'https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/help',
  ];
}
