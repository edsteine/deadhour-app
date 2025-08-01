import 'package:flutter/material.dart';



/// Location selector widget for city/location selection
class LocationSelectorWidget extends StatelessWidget {
  final String selectedCity;
  final VoidCallback? onCityChanged;
  final Color? textColor;
  final double fontSize;

  static const List<String> moroccanCities = [
    'Casablanca',
    'Rabat',
    'Marrakech',
    'Fes',
    'Tangier',
    'Agadir',
    'Meknes',
    'Oujda',
    'Kenitra',
    'Tetouan',
  ];

  const LocationSelectorWidget({
    super.key,
    required this.selectedCity,
    this.onCityChanged,
    this.textColor,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCitySelector(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            size: 14,
            color: textColor ?? Colors.white,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              selectedCity,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: textColor ?? Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.arrow_drop_down,
            size: 16,
            color: textColor ?? Colors.white,
          ),
        ],
      ),
    );
  }

  void _showCitySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CitySelectionBottomSheet(
        selectedCity: selectedCity,
        onCitySelected: (city) {
          Navigator.pop(context);
          if (onCityChanged != null) {
            onCityChanged!();
          }
        },
      ),
    );
  }
}

