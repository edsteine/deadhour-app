# DeadHour Flutter Project Makefile
# Essential commands for development workflow

.PHONY: help setup format build git icons splash

# Default target - show help
help:
	@echo "🇲🇦 DeadHour Flutter Project Commands"
	@echo "===================================="
	@echo ""
	@echo "📦 Setup:"
	@echo "  make setup     - Clean and get dependencies"
	@echo ""
	@echo "🔧 Development:"
	@echo "  make format    - Format Dart code"
	@echo "  make icons     - Generate app launcher icons"
	@echo "  make splash    - Generate splash screen"
	@echo ""
	@echo "🏗️ Build:"
	@echo "  make build     - Build debug APK"
	@echo "  make build-prod - Build production APK"
	@echo ""
	@echo "📝 Git:"
	@echo "  make git       - Add, commit, and push"
	@echo ""

# 📦 Setup
setup:
	@echo "🧹 Cleaning and setting up project..."
	@flutter clean
	@rm -rf build/
	@rm -rf .dart_tool/
	@flutter pub get
	@echo "✅ Project setup complete!"

format:
	@echo "✨ Formatting Dart code..."
	@dart format lib/ --set-exit-if-changed
	@echo "✅ Code formatted!"

# 🎨 Assets Generation
icons:
	@echo "🎨 Generating app launcher icons..."
	@dart run flutter_launcher_icons
	@echo "✅ App launcher icons generated!"

splash:
	@echo "🌊 Generating splash screen..."
	@dart run flutter_native_splash:create
	@echo "✅ Splash screen generated!"

# 🏗️ Build Commands  
build:
	@echo "🏗️ Building debug APK..."
	@flutter build apk --debug
	@echo "✅ Debug APK built: build/app/outputs/flutter-apk/app-debug.apk"

build-prod:
	@echo "🏗️ Building production APK..."
	@flutter build apk --release --target-platform android-arm64
	@echo "✅ Production APK built: build/app/outputs/flutter-apk/app-release.apk"

# 📝 Git Commands
git:
	@echo "📝 Git: add, commit, and push..."
	@git add .
	@read -p "Enter commit message (or press Enter for 'Update project'): " msg; \
	if [ -z "$$msg" ]; then \
		git commit -m "Update project"; \
	else \
		git commit -m "$$msg"; \
	fi
	@git push
	@echo "✅ Changes pushed to remote!"

