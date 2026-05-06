class IncentivoModel {
  static bool calculoUnidades(
    int lun,
    int mart,
    int mier,
    int juev,
    int vier,
    int sab,
  ) {
    return (lun + mart + mier + juev + vier + sab > 600) ? true : false;
  }
}
