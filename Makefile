# DeadHour Flutter Project Makefile
# Essential commands for development workflow

.PHONY: help setup clean deps format lint test build git-init git-commit git-push run install

# Default target - show help
help:
	@echo "🇲🇦 DeadHour Flutter Project Commands"
	@echo "===================================="
	@echo ""
	@echo "📦 Setup & Dependencies:"
	@echo "  make setup     - Initial project setup (clean + deps)"
	@echo "  make deps      - Get Flutter dependencies"
	@echo "  make clean     - Clean build files and caches"
	@echo ""
	@echo "🔧 Development:"
	@echo "  make run       - Run the app in debug mode"
	@echo "  make format    - Format all Dart code"
	@echo "  make lint      - Run static analysis"
	@echo "  make test      - Run all tests"
	@echo ""
	@echo "🏗️ Build:"
	@echo "  make build     - Build APK for testing"
	@echo "  make build-prod - Build production APK"
	@echo ""
	@echo "📝 Git Workflow:"
	@echo "  make git-init   - Initialize git repository"
	@echo "  make git-commit - Add all files and commit"
	@echo "  make git-push   - Push to remote"
	@echo ""
	@echo "🚀 Quick Commands:"
	@echo "  make install   - Full setup for new developers"
	@echo ""

# 📦 Setup & Dependencies
setup: clean deps
	@echo "✅ Project setup complete!"

deps:
	@echo "📦 Getting Flutter dependencies..."
	@flutter pub get

clean:
	@echo "🧹 Cleaning project..."
	@flutter clean
	@rm -rf build/
	@rm -rf .dart_tool/

# 🔧 Development Commands
run:
	@echo "🚀 Running DeadHour app..."
	@flutter run

format:
	@echo "✨ Formatting Dart code..."
	@dart format lib/ --set-exit-if-changed
	@echo "✅ Code formatted!"

lint:
	@echo "🔍 Running static analysis..."
	@flutter analyze --no-fatal-infos
	@echo "✅ Analysis complete!"

test:
	@echo "🧪 Running tests..."
	@flutter test
	@echo "✅ Tests complete!"

# 🏗️ Build Commands  
build:
	@echo "🏗️ Building debug APK..."
	@flutter build apk --debug
	@echo "✅ Debug APK built: build/app/outputs/flutter-apk/app-debug.apk"

build-prod:
	@echo "🏗️ Building production APK..."
	@flutter build apk --release --target-platform android-arm64
	@echo "✅ Production APK built: build/app/outputs/flutter-apk/app-release.apk"

# 📝 Git Workflow Commands
git-init:
	@echo "🎯 Initializing git repository..."
	@git init
	@echo "✅ Git repository initialized!"

git-commit:
	@echo "📝 Adding and committing all changes..."
	@git add .
	@git status
	@read -p "Enter commit message (or press Enter for 'Update project'): " msg; \
	if [ -z "$$msg" ]; then \
		git commit -m "Update project"; \
	else \
		git commit -m "$$msg"; \
	fi
	@echo "✅ Changes committed!"

git-push:
	@echo "🚀 Pushing to remote repository..."
	@git push
	@echo "✅ Pushed to remote!"

# Git shortcut for first commit
git-first-commit:
	@echo "🎯 Setting up first commit..."
	@git add .
	@git commit -m "🎉 Initial commit: DeadHour Morocco app"
	@echo "✅ First commit ready! Use 'make git-push' to push to remote."

# 🚀 Quick Setup for New Developers
install: setup
	@echo "🎉 DeadHour development environment ready!"
	@echo ""
	@echo "📱 Next steps:"
	@echo "  1. Connect your device or start emulator"
	@echo "  2. Run: make run"
	@echo "  3. Start developing! 🇲🇦"

# Development workflow shortcuts
dev-check: format lint test
	@echo "✅ Development checks complete!"

quick-build: dev-check build
	@echo "✅ Quick build complete!"

# Maintenance commands
doctor:
	@echo "🩺 Running Flutter doctor..."
	@flutter doctor

upgrade:
	@echo "⬆️ Upgrading Flutter and dependencies..."
	@flutter upgrade
	@flutter pub upgrade

# Clean everything (nuclear option)
nuke: 
	@echo "💥 Nuclear clean (removes all generated files)..."
	@flutter clean
	@rm -rf build/
	@rm -rf .dart_tool/
	@rm -rf android/.gradle/
	@rm -rf ios/.symlinks/
	@rm -rf linux/flutter/
	@rm -rf macos/Flutter/
	@rm -rf windows/flutter/
	@echo "✅ Nuclear clean complete!"