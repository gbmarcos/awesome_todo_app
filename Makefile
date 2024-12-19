.PHONY: build gen clean buil_apk_relese watch
build:
	@echo "╠ Generating files..."
	@fvm flutter pub run build_runner build --delete-conflicting-outputs
	@fvm flutter pub get

watch:
	@echo "╠ Watching files for generation..."
	@fvm flutter pub run build_runner watch --delete-conflicting-outputs

gen: ## Generates the assets
	@echo "╠ Generating the assets..."
	@fvm flutter pub get
	@fvm flutter packages pub run build_runner build

clean: ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@fvm flutter clean
	@fvm flutter pub get

pub_get: ## Cleans the environment
	@echo "╠ Pub Get..."
	@fvm flutter pub get

buil_apk_relese:
	@echo "╠ Building release apk..."
	@fvm flutter build apk --release

assemble_debug: ## download debug android dependencies
	@echo "╠ Downloading debug android dependencies..."
	@(cd android && ./gradlew assembleDebug)


assemble_release: ## download debug android dependencies
	@echo "╠ Downloading release android dependencies..."
	@(cd android && ./gradlew assembleRelease)