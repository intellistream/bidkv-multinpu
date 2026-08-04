PYTHON ?= python3

.PHONY: help install-dev smoke test shared-workloads-smoke shared-workloads-test lint format build bench paper

help:
	@printf '%s\n' 'install-dev smoke test shared-workloads-smoke shared-workloads-test lint format build bench paper'

install-dev:
	@if [ -f pyproject.toml ]; then $(PYTHON) -m pip install -e '.[dev]'; else printf '%s\n' 'ERROR: pyproject.toml is not present; define the repository build/install contract.' >&2; exit 2; fi

smoke: test

test:
	@if [ -d tests ]; then $(PYTHON) -m pytest -q; else printf '%s\n' 'ERROR: tests/ is not present; add repository-owned validation.' >&2; exit 2; fi

shared-workloads-smoke:
	@if [ -f .benchmarks/run_shared_workloads_smoke.py ]; then $(PYTHON) .benchmarks/run_shared_workloads_smoke.py; else printf '%s\n' 'ERROR: shared-workload harness is not implemented for this repository.' >&2; exit 2; fi

shared-workloads-test: shared-workloads-smoke

lint:
	@if [ -d src ]; then $(PYTHON) -m ruff check src tests; else printf '%s\n' 'ERROR: src/ is not present.' >&2; exit 2; fi

format:
	@if [ -d src ]; then $(PYTHON) -m ruff format src tests; else printf '%s\n' 'ERROR: src/ is not present.' >&2; exit 2; fi

build:
	@if [ -f pyproject.toml ]; then $(PYTHON) -m build; else printf '%s\n' 'ERROR: pyproject.toml is not present.' >&2; exit 2; fi

bench:
	@if [ -d experiments ]; then printf '%s\n' 'Use the documented repository-owned experiment entrypoint under experiments/.'; else printf '%s\n' 'ERROR: experiments/ is not present.' >&2; exit 2; fi

paper:
	@if [ -d paper ]; then $(MAKE) -C paper; else printf '%s\n' 'ERROR: paper/ is not present.' >&2; exit 2; fi
