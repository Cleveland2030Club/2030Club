$(document).ready(function() {
  $('#quantity').keyup(function () {
    var totalCalculator = new TotalCalculator();
    var quantity = $(this).val();
    var price = $('#event_price').text();
    $('#total').text(totalCalculator.calculate(quantity, price));
  })
});

function TotalCalculator() {
}

TotalCalculator.prototype.calculate = function(quantity, price) {
  var _quantity = parseInt(quantity);
  if (isNaN(_quantity))
    return 'N/A';

  var _price = parseInt(price.replace('$', ''));
  var total = _quantity * _price;
  return '$' + total.toFixed(2);
}
