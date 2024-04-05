class AppRoutes{

  static const listDeputados = '/listDeputados';
  static const listDeputadosDetail = '/listDeputadosDetail';


  String getRoute(String route){
    switch(route){
      case 'listDeputados':
        return listDeputados;
      case 'listDeputadosDetail':
        return listDeputadosDetail;
      default:
        return '';
    }
  }

  String getInitialPage() => listDeputados;
}