# bike_rental_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Google Maps Web Setup

If you run the web app and see `Google Maps JavaScript API error: InvalidKeyMapError`,
the key in `web/index.html` is invalid for Maps JavaScript API.

1. Open Google Cloud Console and select your project.
2. Enable `Maps JavaScript API`.
3. Make sure billing is enabled for the project.
4. Create an API key for web/browser usage.
5. Restrict the key by HTTP referrers and include at least:
	- `http://localhost/*`
	- `http://localhost:*/*`
	- `http://127.0.0.1/*`
	- `http://127.0.0.1:*/*`
6. Replace `YOUR_GOOGLE_MAPS_WEB_API_KEY` in `web/index.html` with your key.

After updating the key, restart the Flutter web app.
