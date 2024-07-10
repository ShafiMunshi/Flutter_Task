class AppAssets {
  const AppAssets._();

  static String get api=>'api_ends'.svg;
  static String get calendar=>'calendar'.svg;
  static String get camera=>'camera'.svg;
  static String get clock=>'clock'.svg;
  static String get correct=>'correct'.svg;
  static String get docs=>'docs'.svg;
  static String get home=>'home'.svg;
  static String get house=>'house'.svg;
  static String get library=>'library'.svg;
  static String get menu=>'menu'.svg;
  static String get notification=>'notification'.svg;
  static String get people=>'people'.svg;
  static String get profile=>'profile'.svg;
  static String get sitPeople=>'sitting_people'.svg;
  static String get location=>'locations'.svg;
  static String get cameraImg=>'cameraa'.png;
  static String get demoImg=>'demo'.png;
  static String get avatarImg=>'avatar'.png;

}

extension on String{
  String get png=>'assets/images/$this.png';
  String get svg=>'assets/icons/$this.svg';
}