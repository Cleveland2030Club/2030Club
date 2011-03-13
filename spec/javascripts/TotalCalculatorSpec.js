describe("TotalCalculator", function() {
  var totalCalculator;

  beforeEach(function() {
    totalCalculator = new TotalCalculator();
  });

  it('calculates total from integer strings', function() {
    var result = totalCalculator.calculate('2', '$15.00');
    expect(result).toEqual('$30.00');
  });

  it('calculates total from double string', function() {
    var result = totalCalculator.calculate('2.3', '$15.00');
    expect(result).toEqual('$30.00');
  });

  it('handles non-numeric quantity', function() {
    var result = totalCalculator.calculate('He', '$15.00');
    expect(result).toEqual('N/A');
  });
});
