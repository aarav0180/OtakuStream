import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Backend/Api/api_service.dart';
import '../Providers/home_provider.dart';

class ProviderSelector extends StatefulWidget {
  const ProviderSelector({Key? key}) : super(key: key);

  @override
  State<ProviderSelector> createState() => _ProviderSelectorState();
}

class _ProviderSelectorState extends State<ProviderSelector> with SingleTickerProviderStateMixin {
  AnimeProvider _selectedProvider = AnimeProvider.brainudeu;
  bool _isLoaded = false;
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _loadSavedProvider();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final savedProvider = prefs.getString('selectedProvider') ?? 'brainudeu';
    final provider = AnimeProvider.values.firstWhere(
      (p) => p.toString().split('.').last == savedProvider,
      orElse: () => AnimeProvider.brainudeu,
    );

    if (!mounted) {
      _selectedProvider = provider;
      _isLoaded = true;
      ApiService.setProvider(provider);
      return;
    }

    setState(() {
      _selectedProvider = provider;
      _isLoaded = true;
      _isExpanded = false;
    });

    ApiService.setProvider(provider);
  }

  Future<void> _saveProvider(AnimeProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedProvider', provider.toString().split('.').last);
  }

  void _changeProvider(AnimeProvider newProvider) async {
    setState(() {
      _selectedProvider = newProvider;
      _isExpanded = false;
    });
    _animationController.reverse();
    
    ApiService.setProvider(newProvider);
    await _saveProvider(newProvider);
    
    // Refresh home data with new provider
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Switched to ${ApiService.providers[newProvider]!.displayName}'),
          duration: const Duration(seconds: 2),
        ),
      );
      context.read<HomeProvider>().fetchHomeAnime();
    }
  }

  void _toggleExpand() {
    if (!_isLoaded) return;
    setState(() {
      _isExpanded = !_isExpanded;
    });
    
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  String get _currentProviderName {
    return ApiService.providers[_selectedProvider]?.displayName ?? 'Select Provider';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Compact Button - Always Visible
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _toggleExpand,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: _isExpanded ? 12 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.language,
                          color: Colors.orange,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            _isLoaded ? _currentProviderName : 'Loading provider...',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        RotationTransition(
                          turns: _expandAnimation,
                          child: const Icon(
                            Icons.expand_more,
                            color: Colors.orange,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Expanded List - Conditional
        SizeTransition(
          sizeFactor: _expandAnimation,
          axisAlignment: -1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[700]!, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Switch Provider',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ApiService.getAllProviders().map((config) {
                    final isSelected = _selectedProvider == config.provider;
                    return GestureDetector(
                      onTap: () => _changeProvider(config.provider),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.orange : Colors.grey[800],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isSelected ? Colors.orange : Colors.grey[700]!,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          config.displayName,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.grey[300],
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
