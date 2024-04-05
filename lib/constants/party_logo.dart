class PartyLogo{
  static const String pt = 'assets/images/pt.png';
  static const String psdb = 'assets/images/psdb.png';
  static const String mdb = 'assets/images/mdb.png';
  static const String psol = 'assets/images/psol.png';
  static const String psl = 'assets/images/psl.png';
  static const String pcdob = 'assets/images/pcdob.png';
  static const String noParty = 'assets/images/no_party.png';


  static String getLogo(String party){

    party = party.toUpperCase();

    switch(party){
      case 'PT':
        return pt;
      case 'PSDB':
        return psdb;
      case 'MDB':
        return mdb;
      case 'PSOL':
        return psol;
      case 'PSL':
        return psl;
      case 'PCDOB':
        return pcdob;
      default:
        return noParty;
    }
  }
}
