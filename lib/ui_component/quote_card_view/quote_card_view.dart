import 'package:flutter/material.dart';
import 'package:quokka/ui_component/quote_card_view/quote_card_view_model.dart';

class QuoteCardView extends StatelessWidget {
  final QuoteCardViewModel viewModel;

  const QuoteCardView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewModel.body,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          if (viewModel.author != null)
            Text(
              viewModel.author!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.favorite_outline,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                viewModel.favoritesCount,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
