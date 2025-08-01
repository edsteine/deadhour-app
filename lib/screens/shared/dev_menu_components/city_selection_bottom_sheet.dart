import 'package:flutter/material.dart';


/// City selection bottom sheet
class CitySelectionBottomSheet extends StatelessWidget {
  final String selectedCity;
  final Function(String) onCitySelected;

  const CitySelectionBottomSheet({
    super.key,
    required this.selectedCity,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          const Text(
            'Select City',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // City list
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: LocationSelectorWidget.moroccanCities.length,
              itemBuilder: (context, index) {
                final city = LocationSelectorWidget.moroccanCities[index];
                final isSelected = city == selectedCity;

                return ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: isSelected ? Theme.of(context).primaryColor : null,
                  ),
                  title: Text(
                    city,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                  trailing: isSelected 
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                  onTap: () => onCitySelected(city),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Current location option
          ListTile(
            leading: const Icon(Icons.my_location),
            title: const Text('Use Current Location'),
            subtitle: const Text('Detect automatically'),
            onTap: () {
              // Here we would implement location detection
              onCitySelected('Current Location');
            },
          ),
        ],
      ),
    );
  }
}