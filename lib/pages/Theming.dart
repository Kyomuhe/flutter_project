import 'package:flutter/material.dart';

class ThemingPage extends StatefulWidget {
  const ThemingPage({super.key});

  @override
  State<ThemingPage> createState() => _ThemingPageState();
}

class _ThemingPageState extends State<ThemingPage> {
  bool _useDarkTheme = false;
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _useDarkTheme = !_useDarkTheme;
      _themeMode = _useDarkTheme ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Theming',
          style: TextStyle(color: Colors.white,),),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(_useDarkTheme ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleTheme,
              tooltip: 'Toggle theme',
            ),
          ],
        ),
        body: const ThemingContent(),
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class ThemingContent extends StatelessWidget {
  const ThemingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildThemeSetup(context),
          const SizedBox(height: 24),
          _buildColorSchemeExample(context),
          const SizedBox(height: 24),
          _buildTypographyExample(context),
          const SizedBox(height: 24),
          _buildComponentExample(context),
          const SizedBox(height: 24),
          _buildCustomComponentExample(context),
          const SizedBox(height: 24),
          _buildResponsiveThemingExample(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.color_lens, color: colorScheme.primary, size: 36),
                const SizedBox(width: 12),
                Text(
                  'Flutter Theming',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Creating consistent, beautiful themes across Flutter applications',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Tap the theme toggle icon in the app bar(right) to see light/dark mode in action',
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSetup(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final codeStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 13,
      color: colorScheme.onSurfaceVariant,
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Setting Up Themes'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Theme Configuration',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'MaterialApp(\n'
                    '  theme: ThemeData(\n'
                    '    useMaterial3: true,\n'
                    '    colorScheme: ColorScheme.fromSeed(\n'
                    '      seedColor: Colors.blue,\n'
                    '      brightness: Brightness.light,\n'
                    '    ),\n'
                    '    // Other theme configurations\n'
                    '  ),\n'
                    '  darkTheme: ThemeData(\n'
                    '    useMaterial3: true,\n'
                    '    colorScheme: ColorScheme.fromSeed(\n'
                    '      seedColor: Colors.blue,\n'
                    '      brightness: Brightness.dark,\n'
                    '    ),\n'
                    '  ),\n'
                    '  themeMode: ThemeMode.system, // .light, .dark, .system\n'
                    ')',
                    style: codeStyle,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Material 3 Key Concepts:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoItem(
                  context,
                  '• Color Scheme',
                  'A unified way to define colors with semantic meanings, ensuring consistency across your app',
                ),
                _buildInfoItem(
                  context,
                  '• Typography',
                  'Pre-defined text styles for different purposes like headlines, body text, and captions',
                ),
                _buildInfoItem(
                  context,
                  '• Component Themes',
                  'Consistent styling applied to widgets like buttons, cards, and input fields',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildColorSchemeExample(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Color Scheme'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Primary Colors',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildColorGroup(
                  context,
                  [
                    ColorInfo('Primary', colorScheme.primary, colorScheme.onPrimary),
                    ColorInfo('PrimaryContainer', colorScheme.primaryContainer, colorScheme.onPrimaryContainer),
                    ColorInfo('Secondary', colorScheme.secondary, colorScheme.onSecondary),
                    ColorInfo('Tertiary', colorScheme.tertiary, colorScheme.onTertiary),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Surface Colors',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildColorGroup(
                  context,
                  [
                    ColorInfo('Surface', colorScheme.surface, colorScheme.onSurface),
                    ColorInfo('SurfaceVariant', colorScheme.surfaceVariant, colorScheme.onSurfaceVariant),
                    ColorInfo('Background', colorScheme.background, colorScheme.onBackground),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Semantic Colors',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildColorGroup(
                  context,
                  [
                    ColorInfo('Error', colorScheme.error, colorScheme.onError),
                    ColorInfo('ErrorContainer', colorScheme.errorContainer, colorScheme.onErrorContainer),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorGroup(BuildContext context, List<ColorInfo> colors) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: colors.map((colorInfo) => _buildColorItem(context, colorInfo)).toList(),
    );
  }

  Widget _buildColorItem(BuildContext context, ColorInfo colorInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: colorInfo.color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Aa',
              style: TextStyle(
                color: colorInfo.onColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          colorInfo.name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '#${colorInfo.color.value.toRadixString(16).substring(2).toUpperCase()}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildTypographyExample(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Typography'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextStyleExample(
                  context,
                  'Display Large',
                  textTheme.displayLarge,
                  'Headline & Hero Text',
                ),
                const Divider(),
                _buildTextStyleExample(
                  context,
                  'Headline Large',
                  textTheme.headlineLarge,
                  'Section Headers',
                ),
                _buildTextStyleExample(
                  context,
                  'Headline Medium',
                  textTheme.headlineMedium,
                  'Feature Titles',
                ),
                const Divider(),
                _buildTextStyleExample(
                  context,
                  'Title Large',
                  textTheme.titleLarge,
                  'Card Headers',
                ),
                _buildTextStyleExample(
                  context,
                  'Title Medium',
                  textTheme.titleMedium,
                  'Dialog Headers',
                ),
                const Divider(),
                _buildTextStyleExample(
                  context,
                  'Body Large',
                  textTheme.bodyLarge,
                  'Primary Content',
                ),
                _buildTextStyleExample(
                  context,
                  'Body Medium',
                  textTheme.bodyMedium,
                  'Secondary Content',
                ),
                const Divider(),
                _buildTextStyleExample(
                  context,
                  'Label Large',
                  textTheme.labelLarge,
                  'Button Text',
                ),
                _buildTextStyleExample(
                  context,
                  'Label Small',
                  textTheme.labelSmall,
                  'Captions & Subtitles',
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Typography Best Practices:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Use the built-in text theme hierarchy consistently\n'
                        '• Avoid hardcoding fonts and sizes\n'
                        '• Reference styles with Theme.of(context).textTheme\n'
                        '• Customize the text theme in your ThemeData',
                        style: TextStyle(color: colorScheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextStyleExample(
    BuildContext context,
    String name,
    TextStyle? style,
    String usage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  usage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              'The quick brown fox',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Component Theming'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Button Styles',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Elevated'),
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Filled'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Outlined'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Text'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Input Components',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Text Field',
                    hintText: 'Type something...',
                  ),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Checkbox Example'),
                  value: true,
                  onChanged: (_) {},
                ),
                SwitchListTile(
                  title: const Text('Switch Example'),
                  value: true,
                  onChanged: (_) {},
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: const Text('Basic Chip'),
                      avatar: Icon(Icons.tag, size: 16, color: Theme.of(context).colorScheme.primary),
                    ),
                    FilterChip(
                      label: const Text('Filter'),
                      selected: true,
                      onSelected: (_) {},
                    ),
                    ActionChip(
                      label: const Text('Action'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomComponentExample(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Custom Component Theming'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Define Custom Theme Extensions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '// Example of a custom theme extension\n'
                    'class MyAppColors extends ThemeExtension<MyAppColors> {\n'
                    '  final Color featureCardBackground;\n'
                    '  final Color featureCardText;\n'
                    '\n'
                    '  MyAppColors({\n'
                    '    required this.featureCardBackground,\n'
                    '    required this.featureCardText,\n'
                    '  });\n'
                    '\n'
                    '  @override\n'
                    '  ThemeExtension<MyAppColors> copyWith({\n'
                    '    Color? featureCardBackground,\n'
                    '    Color? featureCardText,\n'
                    '  }) {\n'
                    '    return MyAppColors(\n'
                    '      featureCardBackground: featureCardBackground ?? this.featureCardBackground,\n'
                    '      featureCardText: featureCardText ?? this.featureCardText,\n'
                    '    );\n'
                    '  }\n'
                    '\n'
                    '  @override\n'
                    '  ThemeExtension<MyAppColors> lerp(\n'
                    '    covariant ThemeExtension<MyAppColors>? other,\n'
                    '    double t,\n'
                    '  ) {\n'
                    '    if (other is! MyAppColors) return this;\n'
                    '    return MyAppColors(\n'
                    '      featureCardBackground: Color.lerp(\n'
                    '        featureCardBackground,\n'
                    '        other.featureCardBackground,\n'
                    '        t,\n'
                    '      )!,\n'
                    '      featureCardText: Color.lerp(\n'
                    '        featureCardText,\n'
                    '        other.featureCardText,\n'
                    '        t,\n'
                    '      )!,\n'
                    '    );\n'
                    '  }\n'
                    '}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Apply in Theme',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'ThemeData(\n'
                    '  // ... other theme properties\n'
                    '  extensions: <ThemeExtension>[\n'
                    '    MyAppColors(\n'
                    '      featureCardBackground: Colors.teal.shade50,\n'
                    '      featureCardText: Colors.teal.shade900,\n'
                    '    ),\n'
                    '  ],\n'
                    ')',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Use in Widget',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'final myColors = Theme.of(context).extension<MyAppColors>();\n'
                    'return Container(\n'
                    '  color: myColors?.featureCardBackground,\n'
                    '  child: Text(\n'
                    '    "Feature Card",\n'
                    '    style: TextStyle(color: myColors?.featureCardText),\n'
                    '  ),\n'
                    ');',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveThemingExample(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Responsive Theming'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adjusting Themes for Screen Size',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'ThemeData responsiveTheme(BuildContext context) {\n'
                    '  // Get screen width\n'
                    '  final width = MediaQuery.of(context).size.width;\n'
                    '  \n'
                    '  // Base theme\n'
                    '  var theme = ThemeData(\n'
                    '    useMaterial3: true,\n'
                    '    colorScheme: ColorScheme.fromSeed(\n'
                    '      seedColor: Colors.blue,\n'
                    '    ),\n'
                    '  );\n'
                    '  \n'
                    '  // Adjust for small screens\n'
                    '  if (width < 600) {\n'
                    '    theme = theme.copyWith(\n'
                    '      textTheme: theme.textTheme.copyWith(\n'
                    '        headlineLarge: theme.textTheme.headlineLarge?.copyWith(fontSize: 24),\n'
                    '        bodyLarge: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),\n'
                    '      ),\n'
                    '      cardTheme: CardTheme(\n'
                    '        margin: const EdgeInsets.symmetric(vertical: 8),\n'
                    '        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),\n'
                    '      ),\n'
                    '    );\n'
                    '  } \n'
                    '  // Adjust for large screens\n'
                    '  else {\n'
                    '    theme = theme.copyWith(\n'
                    '      textTheme: theme.textTheme.copyWith(\n'
                    '        headlineLarge: theme.textTheme.headlineLarge?.copyWith(fontSize: 32),\n'
                    '        bodyLarge: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),\n'
                    '      ),\n'
                    '      cardTheme: CardTheme(\n'
                    '        margin: const EdgeInsets.symmetric(vertical: 16),\n'
                    '        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),\n'
                    '      ),\n'
                    '    );\n'
                    '  }\n'
                    '  \n'
                    '  return theme;\n'
                    '}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Key Responsive Theming Tips:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoItem(
                  context,
                  '• Adaptive Fonts',
                  'Scale font sizes based on screen dimensions',
                ),
                _buildInfoItem(
                  context,
                  '• Responsive Spacing',
                  'Adjust padding and margins for different screen sizes',
                ),
                _buildInfoItem(
                  context,
                  '• Component Size Adaptation',
                  'Use smaller/larger components depending on available space',
                ),
                _buildInfoItem(
                  context,
                  '• Density Considerations',
                  'Adjust touch target sizes for different input methods',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorInfo {
  final String name;
  final Color color;
  final Color onColor;

  ColorInfo(this.name, this.color, this.onColor);
}
