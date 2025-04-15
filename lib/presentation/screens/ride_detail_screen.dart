import 'package:flutter/material.dart';

// Screen to display the detailed view of a single upcoming ride.
class RideDetailScreen extends StatelessWidget {
  final Map<String, dynamic> rideData;
  final String heroTag; // Tag to match the Hero from the list item

  const RideDetailScreen({
    super.key,
    required this.rideData,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // TODO: Build a more detailed layout later
    // For now, mimic the card structure within a Scaffold and use the Hero

    return Scaffold(
      appBar: AppBar(
        title: Text('${rideData['date']} Ride'), // Simple title
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center( // Center the expanding card for now
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Hero(
            tag: heroTag, // Use the unique tag passed from the list
            child: Material( // Hero child needs to be Material or similar
              type: MaterialType.transparency, // Avoid double background
              child: Card(
                elevation: 4, // Slightly more elevation maybe
                margin: EdgeInsets.zero,
                color: colorScheme.surfaceVariant.withOpacity(0.5), // Match card style
                clipBehavior: Clip.antiAlias, 
                child: SingleChildScrollView( // Wrap content in ScrollView
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Slightly more padding
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Keep card size tight
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Mimic Card Header --- 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              rideData['date'] as String,
                              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
                            ),
                            Text(
                              '${rideData['pickupTime']} - ${rideData['dropTime']}',
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const Divider(height: 30),

                        // --- Expanded Details Section ---
                        Text('Pickup Location', style: textTheme.labelLarge),
                        Text(rideData['pickupLocation']?.substring(7) ?? '', style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 16),

                        Text('Drop Location', style: textTheme.labelLarge),
                        Text(rideData['dropLocation']?.substring(6) ?? '', style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 16),

                        // Placeholder for Map Preview
                        Container(
                          height: 150,
                          color: colorScheme.surfaceVariant,
                          child: const Center(child: Text('[ Map Preview Area ]', style: TextStyle(fontStyle: FontStyle.italic))), 
                        ),
                        const Divider(height: 30),

                        // Driver Info Section (similar to card)
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24, // Slightly larger
                              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                              child: Text(rideData['driverName'].toString()[0], style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(rideData['driverName'] as String, style: textTheme.titleMedium),
                                  Text('${rideData['vehicleModel']} - ${rideData['vehicleNumber']}', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 18, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(rideData['driverRating'].toString(), style: textTheme.bodyLarge),
                                  ],
                                ),
                                Text(rideData['otp'] as String, style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Placeholder for Action Buttons (e.g., Cancel Ride)
                        Center(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.cancel_outlined),
                            label: const Text('Cancel Ride'),
                            style: ElevatedButton.styleFrom(backgroundColor: colorScheme.error, foregroundColor: colorScheme.onError),
                            onPressed: () {
                              // TODO: Implement cancel functionality
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 