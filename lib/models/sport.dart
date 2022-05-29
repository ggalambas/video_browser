enum Sport {
  americanFootball,
  aussieRules,
  badminton,
  bandy,
  baseball,
  basketball,
  beachSoccer,
  beachVolleyball,
  boxing,
  cricket,
  cycling,
  darts,
  esports,
  fieldHockey,
  floorball,
  football,
  futsal,
  golf,
  handball,
  hockey,
  horseRacing,
  kabaddi,
  mma,
  motorsport,
  netball,
  pesapallo,
  rugbyLeague,
  rugbyUnion,
  snooker,
  tableTennis,
  tennis,
  volleyball,
  waterPolo,
  winterSports;

  @override
  String toString() {
    final separatedName = name.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => ' ${match.group(0)!.toLowerCase()}',
    );
    return separatedName[0].toUpperCase() + separatedName.substring(1);
  }
}
