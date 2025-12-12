# HTA Schema Specification

**Version:** 0.1.0 (Decision Trees)  
**Status:** Initial Release  
**License:** Apache 2.0

## What is HTA Schema?

HTA Schema is a universal JSON-based format for representing Health Technology Assessment (HTA) economic models. It provides a standardized way to specify decision trees, Markov models, and microsimulations that can be validated, executed, and shared across different tools and platforms.

## Purpose

The specification aims to:
- **Standardize** HTA model representation
- **Enable validation** of model structure and parameters
- **Facilitate sharing** and peer review
- **Support tool interoperability** across R, Python, Excel, TreeAge, etc.
- **Improve transparency** in health economic evaluation

## Current Version (v0.1)

Version 0.1 covers **Decision Tree Models** with:
- Decision, chance, and terminal nodes
- Cost and utility outcomes
- Probabilistic parameter specifications
- Discounting and sensitivity analysis settings
- Complete metadata and documentation

## Files in This Repository

- `schema/hta_schema_v0.1.json` - Formal JSON Schema definition
- `specification/HTA_Schema_Technical_Specification_v0.1.md` - Complete technical documentation
- `examples/basic_decision_tree.json` - Minimal working example
- `CHANGELOG.md` - Version history

## Quick Example

```json
{
  "schema_version": "0.1.0",
  "model_metadata": {
    "model_name": "Treatment Comparison",
    "model_type": "decision_tree",
    ...
  },
  "model_structure": {
    "root_node": "decision_1",
    "nodes": { ... }
  },
  "parameters": { ... },
  "analysis_settings": { ... }
}
```

## Validation

Models can be validated against the schema using standard JSON Schema validators:

**Python:**
```python
from jsonschema import validate
validate(instance=model, schema=schema)
```

**JavaScript:**
```javascript
const Ajv = require('ajv');
const valid = ajv.validate(schema, model);
```

## Tools & Implementations

For tools that work with HTA Schema (viewers, validators, converters), see:
**[hta-schema-tools](https://github.com/[username]/hta-schema-tools)**

## Roadmap

- **v0.2** (Q1 2025): Markov cohort models
- **v0.3** (Q2 2025): Time-to-event models
- **v0.4** (Q3 2025): Microsimulation
- **v1.0** (Q4 2025): Stable release with EVPI support

## Governance

### Schema Changes
Changes to the specification follow a formal process:
1. Proposal via GitHub issue
2. Community discussion (30 days minimum)
3. Technical review
4. Approval vote
5. Implementation in reference validator

### Backward Compatibility
- **Minor versions** (0.x.0): Add features, maintain backward compatibility
- **Major versions** (x.0.0): May introduce breaking changes with migration guide

## Contributing

We welcome contributions to the specification. Please see [CONTRIBUTING.md](CONTRIBUTING.md) for:
- How to propose schema changes
- Discussion process
- Example model contributions
- Documentation improvements

## Citation

If you use HTA Schema in academic work:

```
McMeekin P. (2024). HTA Schema: A Universal Format for Health Technology 
Assessment Economic Models. Version 0.1. https://github.com/[username]/hta-schema
```

## License

The HTA Schema specification is licensed under **Apache License 2.0**, which allows:
- ✓ Free use for any purpose (commercial or non-commercial)
- ✓ Modification and distribution
- ✓ Patent protection
- ✓ Implementation without restriction

See [LICENSE](LICENSE) for full terms.

## Commercial Use

The specification is **intentionally open** to encourage widespread adoption. Commercial implementations, tools, and services are explicitly permitted and encouraged.

For commercial tool development, see the [hta-schema-tools](https://github.com/[username]/hta-schema-tools) repository which provides reference implementations.

## Support & Contact

- **Issues:** Use GitHub Issues for bugs or questions about the specification
- **Discussions:** Use GitHub Discussions for general questions
- **Email:** [contact email to be added]

## Acknowledgments

Developed to address the lack of standardization in health technology assessment modeling and improve transparency in healthcare decision-making.

---

**Note:** This repository contains only the specification. For tools, viewers, and implementations, see [hta-schema-tools](https://github.com/[username]/hta-schema-tools).
