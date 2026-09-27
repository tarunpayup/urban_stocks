import 'package:flutter/material.dart';

class MarketHeader extends StatelessWidget {
  final double? currentPrice;
  final String status;

  const MarketHeader({
    super.key,
    required this.currentPrice,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final price = currentPrice;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        8,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          // --------------------------------------------
          // SYMBOL
          // --------------------------------------------

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    'AAPL',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 2),

                  Text(
                    'Apple Inc.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              // ----------------------------------------
              // CONNECTION STATUS
              // ----------------------------------------

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: status == 'connected'
                      ? Colors.green
                          .withOpacity(0.12)
                      : Colors.orange
                          .withOpacity(0.12),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Row(
                  children: [

                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status == 'connected'
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            status == 'connected'
                                ? Colors.green
                                : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],

          ),

          const SizedBox(height: 12),

          // --------------------------------------------
          // CURRENT PRICE
          // --------------------------------------------

          Text(
            price == null
                ? '--'
                : '\$${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}