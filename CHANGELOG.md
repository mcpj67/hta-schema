# Changelog - HTA Schema Specification

All notable changes to the HTA Schema specification will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned for v0.2
- Markov cohort model support
- Transition probability matrices
- Tunnel states
- Half-cycle corrections

### Planned for v0.3
- Time-to-event models
- Partitioned survival models
- Parametric survival distributions

## [0.1.0] - 2024-12-12

### Added
- Initial release of HTA Schema specification
- Decision tree model support
  - Decision nodes
  - Chance nodes
  - Terminal nodes with costs and utilities
- Parameter system
  - Base values for deterministic analysis
  - Probability distributions for PSA
  - Parameter types (probability, cost, utility, rate, relative_risk, duration)
  - Bounds and source documentation
- Analysis settings
  - Time horizon and discounting
  - Perspective specification
  - Sensitivity analysis specifications (one-way, threshold, probabilistic)
- Metadata system
  - Model identification and versioning
  - Author and provenance tracking
  - Clinical context and references
  - Data source documentation
- JSON Schema definition for validation
- Complete technical specification document
- Simple example model

### Documentation
- Technical Specification v0.1
- JSON Schema with formal validation rules
- README with quick start guide
- Contributing guidelines

## Schema Versioning

Schema versions follow semantic versioning:

- **Major version (X.0.0)**: Breaking changes, models require migration
- **Minor version (0.X.0)**: New features, backward compatible, old models still valid
- **Patch version (0.0.X)**: Bug fixes, clarifications, no structural changes

## Migration Guides

### From v0.0 to v0.1
No migration needed - initial release

---

For the complete specification, see [specification/HTA_Schema_Technical_Specification_v0.1.md](specification/HTA_Schema_Technical_Specification_v0.1.md)

# Changelog

## [0.1.1] - 2024-12-15

### Added
- Expression language support for complex formulas in terminal nodes
- `ValueReference` now supports both `parameter_ref` and `expression`
- Comprehensive expression language specification document
- Support for arithmetic, conditional logic, statistical functions, and discounting
- 25+ built-in functions including discount_stream, gamma_mean, beta_mean, etc.

### Changed
- Enhanced `ValueReference` definition to support expressions alongside parameter references
- Added new parameter types: `count` and `ratio`

### Backward Compatibility
- All v0.1.0 models remain fully valid in v0.1.1
- No breaking changes

## [0.1.0] - 2024-12-12

### Added
- Initial release with decision tree support
- Basic schema structure for HTA models
- Simple parameter references
