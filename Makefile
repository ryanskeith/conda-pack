.PHONY: help setup-env update-env remove-env install install-dev install-test install-docs clean build test test-cov lint format check-docs docs serve-docs clean-build clean-pyc clean-test clean-docs clean-all

# Environment name
ENV_NAME ?= conda-pack-dev

# Default target
help:
	@echo "Available commands:"
	@echo "Environment Management:"
	@echo "  setup-env    - Create development conda environment"
	@echo "  update-env   - Update development conda environment"
	@echo "  remove-env   - Remove conda environments"
	@echo ""
	@echo "Installation:"
	@echo "  install      - Install conda-pack in development mode"
	@echo "  install-dev  - Install development dependencies"
	@echo "  install-test - Install test dependencies"
	@echo "  install-docs - Install documentation dependencies"
	@echo ""
	@echo "Development:"
	@echo "  build        - Build the package"
	@echo "  test         - Run tests"
	@echo "  test-cov     - Run tests with coverage"
	@echo "  lint         - Run linting (flake8, isort)"
	@echo "  format       - Format code (black, isort)"
	@echo "  check-docs   - Check documentation"
	@echo "  docs         - Build documentation"
	@echo "  serve-docs   - Serve documentation locally"
	@echo ""
	@echo "Cleaning:"
	@echo "  clean        - Clean all build artifacts"
	@echo "  clean-build  - Clean build directory"
	@echo "  clean-pyc    - Clean Python cache files"
	@echo "  clean-test   - Clean test artifacts"
	@echo "  clean-docs   - Clean documentation build"

# Environment management targets
setup-env:
	conda env create -f environment-dev.yml

update-env:
	conda env update -f environment-dev.yml

remove-env:
	conda env remove -n conda-pack-dev -y
	conda env remove -n conda-pack-test -y
	conda env remove -n conda-pack-docs -y

# Installation targets (assumes conda environment is active)
install:
	pip install -e .

install-dev:
	pip install -e ".[dev]"

install-test:
	pip install -e ".[test]"

install-docs:
	pip install -e ".[docs]"

# Build target
build:
	python -m build

# Test targets
test:
	pytest

test-cov:
	pytest --cov=conda_pack --cov-report=term-missing --cov-report=xml

# Code quality targets
lint:
	flake8 conda_pack/
	isort --check-only --diff conda_pack/

format:
	black conda_pack/
	isort conda_pack/

# Documentation targets
check-docs:
	cd docs && make check

docs:
	pip install -e ".[docs]"
	cd docs && make html

serve-docs:
	cd docs && python -m http.server 8000 --directory _build/html

# Clean targets
clean: clean-build clean-pyc clean-test clean-docs

clean-build:
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/

clean-pyc:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +

clean-test:
	rm -rf .pytest_cache/
	rm -rf .coverage*
	rm -rf coverage.xml
	rm -rf htmlcov/

clean-docs:
	cd docs && make clean

# Development setup
setup-dev: install-dev
	pre-commit install

# Pre-commit hooks
pre-commit:
	pre-commit run --all-files

# Version management
version:
	python -c "import conda_pack; print(conda_pack.__version__)"

# Check if we're in a git repository
check-git:
	@if [ ! -d .git ]; then \
		echo "Error: This is not a git repository. setuptools-scm requires git."; \
		exit 1; \
	fi

# Install with git check
install-git: check-git install

install-dev-git: check-git install-dev
