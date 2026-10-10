/// One extra-cost line a worker adds to a quote.
class QuoteLine {
  const QuoteLine({required this.itemName, required this.amount});

  final String itemName;
  final num amount;
}
