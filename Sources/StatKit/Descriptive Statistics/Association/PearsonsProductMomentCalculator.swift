/// A helper object for calculating the Pearson Correlation Coefficient.
internal struct PearsonsProductMomentCalculator: CorrelationCalculator {
  internal func compute<T, U, C>(
    for X: KeyPath<C.Element, T>,
    and Y: KeyPath<C.Element, U>,
    in collection: C,
    as composition: DataSetComposition) -> Double
  where T: Comparable & Hashable & ConvertibleToReal,
        U: Comparable & Hashable & ConvertibleToReal,
        C: Collection
  {
  
  guard X != Y else { return 1 }
  
  let XStdDev = standardDeviation(of: collection, variable: X, from: composition)
  let YStdDev = standardDeviation(of: collection, variable: Y, from: composition)
  let stdDevProduct = XStdDev * YStdDev
  if stdDevProduct.isZero {
    return .signalingNaN
  }
  
  switch composition {
    case .population:
      return covariance(collection, of: X, and: Y, from: composition) / stdDevProduct
      
    case .sample:
      let sumOfProducts = collection.reduce(into: 0) { result, element in
        result += element[keyPath: X].realValue * element[keyPath: Y].realValue
      }
      let term = mean(of: collection, variable: X) * mean(of: collection, variable: Y)
      let numerator = sumOfProducts - collection.count.realValue * term
      let denominator = (collection.count - 1).realValue * stdDevProduct
      return numerator / denominator
  }
  }
}
