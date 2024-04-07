class PartyLogo {
  static const String pt = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PT.gif';
  static const String psdb = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PSDB.gif';
  static const String psol = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PSOL.gif';
  static const String psl = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PSL.gif';
  static const String pcdob = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PCDOB.gif';
  static const String ptn = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PTN.gif';
  static const String pps = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PPS.gif';
  static const String prb = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PRB.gif';
  static const String pmn = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PMN.gif';
  static const String psc = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PSC.gif';
  static const String psb = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PSB.gif';
  static const String prp = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PRP.gif';
  static const String psd = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PSD.gif';
  static const String ptc = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PTC.gif';
  static const String pmdb = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PMDB.gif';
  static const String ptb = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PTB.gif';
  static const String pv = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PV.gif';
  static const String pr = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PR.gif';
  static const String ptdob = 'https://www.camara.leg.br/internet/Deputado/img/partidos/PTDOB.gif';
  static const String noParty = 'https://uxwing.com/wp-content/themes/uxwing/download/signs-and-symbols/no-photography-icon.png';

  static String getLogo(String party) {
    party = party.toUpperCase();

    switch (party) {
      case 'PT':
        return pt;
      case 'PSDB':
        return psdb;
      case 'PSOL':
        return psol;
      case 'PSL':
        return psl;
      case 'PCDOB':
        return pcdob;
      case 'PTN':
        return ptn;
      case 'PPS':
        return pps;
      case 'PRB':
        return prb;
      case 'PMN':
        return pmn;
      case 'PSC':
        return psc;
      case 'PSB':
        return psb;
      case 'PRP':
        return prp;
      case 'PSD':
        return psd;
      case 'PTC':
        return ptc;
      case 'PMDB':
        return pmdb;
      case 'PTB':
        return ptb;
      case 'PV':
        return pv;
      case 'PR':
        return pr;
      case 'PTDOB':
        return ptdob;
      default:
        return noParty;
    }
  }
}
