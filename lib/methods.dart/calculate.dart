class Calculate {
  num calculateValue({required num cropPrice, required num cropWeight}) {
    num cropValue = cropPrice * cropWeight;
    return cropValue;
  }

  num calulatepProfitLoss(
      {required num amountInvested, required num currentValue}) {
    num pProfitLoss =
        (((currentValue - amountInvested) / amountInvested) * 100);
    return pProfitLoss;
  }
}
