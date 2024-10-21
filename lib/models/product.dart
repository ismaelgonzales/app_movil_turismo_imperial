enum Calidades  {
  economico,
  accesible,
  exclusivo,
  cargo
}

extension CalidadesExtension on Calidades {
  String get imageName {
    switch (this){
      case Calidades.economico :
        return 'https://res.cloudinary.com/dyelvotz0/image/upload/v1728255535/economico_kg3zac.png' ;
      case Calidades.accesible :
        return 'https://res.cloudinary.com/dyelvotz0/image/upload/v1728255535/accesible_k0me8o.png';
      case Calidades.exclusivo :
        return 'https://res.cloudinary.com/dyelvotz0/image/upload/v1728255535/exclusivo_dxcpt5.png';
      case Calidades.cargo :
        return 'https://res.cloudinary.com/dyelvotz0/image/upload/v1728255535/cargo_bghcic.png';
    }
  }

  String get precio {
    switch (this){
      case Calidades.economico :
        return 'S/80.00' ;
      case Calidades.accesible :
        return 'S/100.00';
      case Calidades.exclusivo :
        return 'S/120.00';
      case Calidades.cargo :
        return 'COTIZAR';  }
  }
  String get nombre {
    switch (this){
      case Calidades.economico :
        return 'Economico' ;
      case Calidades.accesible :
        return 'Accesible';
      case Calidades.exclusivo :
        return 'Exclusivo';
      case Calidades.cargo :
        return 'Cargo';  }
  }
} 