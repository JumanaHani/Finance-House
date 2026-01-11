import 'package:flutter/material.dart';

class AmountSelector extends StatefulWidget {
  final List<double> amounts;
  final ValueChanged<double> onAmountSelected;

  const AmountSelector({
    super.key,
    required this.amounts,
    required this.onAmountSelected,
  });

  @override
  State<AmountSelector> createState() => _AmountSelectorState();
}

class _AmountSelectorState extends State<AmountSelector> {
  double? selectedAmount;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: widget.amounts.map((amount) {
        final isSelected = selectedAmount == amount;
        return ChoiceChip(
          label: Text('AED $amount'),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              selectedAmount = amount;
              widget.onAmountSelected(amount);
            });
          },
        );
      }).toList(),
    );
  }
}
