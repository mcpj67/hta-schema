# HTA Schema Expression Language Specification v0.1.1

## Overview

The HTA Schema Expression Language allows complex mathematical calculations in terminal nodes and other locations where `ValueReference` is used. This enables realistic modeling of health economic outcomes that depend on multiple parameters and sophisticated calculations.

## When to Use Expressions vs Parameter References

- **Use `parameter_ref`**: When the value is a direct lookup of a single parameter
- **Use `expression`**: When the value requires:
  - Arithmetic operations on multiple parameters
  - Mathematical functions (exp, log, sqrt, etc.)
  - Conditional logic
  - Statistical distribution properties
  - Discounting calculations

## Syntax

### Basic Structure

```json
{
  "expression": "mathematical_formula_here",
  "description": "Human-readable explanation (optional)"
}
```

### Variable Names

- All parameter names in expressions must exactly match parameter IDs defined in the `parameters` section
- Case-sensitive
- Must match pattern: `^[a-zA-Z0-9_-]+$`

## Operators

### Arithmetic Operators

| Operator | Description | Example | Result |
|----------|-------------|---------|--------|
| `+` | Addition | `5 + 3` | `8` |
| `-` | Subtraction | `5 - 3` | `2` |
| `*` | Multiplication | `5 * 3` | `15` |
| `/` | Division | `6 / 3` | `2` |
| `^` | Power/Exponentiation | `2 ^ 3` | `8` |
| `%` | Modulo | `7 % 3` | `1` |

**Operator Precedence** (highest to lowest):
1. `^` (Power)
2. `*`, `/`, `%` (Multiplication, Division, Modulo)
3. `+`, `-` (Addition, Subtraction)
4. Comparison operators
5. Logical operators

Use parentheses `()` to override precedence.

### Comparison Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `==` | Equal to | `x == 5` |
| `!=` | Not equal to | `x != 0` |
| `<` | Less than | `x < 10` |
| `>` | Greater than | `x > 0` |
| `<=` | Less than or equal | `x <= 5` |
| `>=` | Greater than or equal | `x >= 1` |

### Logical Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `and` | Logical AND | `x > 0 and x < 10` |
| `or` | Logical OR | `x < 0 or x > 10` |
| `not` | Logical NOT | `not (x == 0)` |

## Functions

### Mathematical Functions

#### Basic Math

| Function | Description | Example |
|----------|-------------|---------|
| `abs(x)` | Absolute value | `abs(-5)` → `5` |
| `sqrt(x)` | Square root | `sqrt(16)` → `4` |
| `exp(x)` | e raised to power x | `exp(1)` → `2.718...` |
| `log(x)` | Natural logarithm (base e) | `log(2.718)` → `1` |
| `ln(x)` | Natural logarithm (alias for log) | `ln(10)` → `2.303` |
| `log10(x)` | Base-10 logarithm | `log10(100)` → `2` |
| `pow(x, y)` | x raised to power y | `pow(2, 3)` → `8` |

#### Rounding Functions

| Function | Description | Example |
|----------|-------------|---------|
| `ceil(x)` | Round up to integer | `ceil(4.2)` → `5` |
| `floor(x)` | Round down to integer | `floor(4.8)` → `4` |
| `round(x)` | Round to nearest integer | `round(4.5)` → `5` |
| `round(x, n)` | Round to n decimal places | `round(3.14159, 2)` → `3.14` |

#### Min/Max Functions

| Function | Description | Example |
|----------|-------------|---------|
| `min(a, b, ...)` | Minimum value | `min(5, 3, 8)` → `3` |
| `max(a, b, ...)` | Maximum value | `max(5, 3, 8)` → `8` |

### Conditional Logic

#### if Function

```
if(condition, true_value, false_value)
```

**Examples:**

```javascript
// Simple condition
if(age >= 65, elderly_cost, adult_cost)

// Nested conditions
if(mrs == 0, cost_mrs0, if(mrs <= 2, cost_mrs12, cost_mrs345))

// With arithmetic
if(life_expectancy > 10, acute_cost + long_term_cost, acute_cost)
```

### Statistical Distribution Functions

These functions return properties of probability distributions, useful when you need expected values or standard deviations for PSA calculations.

#### Normal Distribution

| Function | Description | Parameters |
|----------|-------------|------------|
| `normal_mean(mu, sigma)` | Mean of normal distribution | mu: mean, sigma: SD |
| `normal_sd(mu, sigma)` | Standard deviation | mu: mean, sigma: SD |

**Example:**
```javascript
normal_mean(100, 15)  // Returns 100
normal_sd(100, 15)    // Returns 15
```

#### Gamma Distribution

| Function | Description | Parameters |
|----------|-------------|------------|
| `gamma_mean(shape, scale)` | Mean of gamma distribution | shape: α, scale: β |
| `gamma_sd(shape, scale)` | Standard deviation | shape: α, scale: β |

**Formulas:**
- Mean = shape × scale
- SD = sqrt(shape) × scale

**Example:**
```javascript
gamma_mean(100, 4.5)   // Returns 450
gamma_sd(100, 4.5)     // Returns 45
```

#### Beta Distribution

| Function | Description | Parameters |
|----------|-------------|------------|
| `beta_mean(alpha, beta)` | Mean of beta distribution | alpha: α, beta: β |
| `beta_sd(alpha, beta)` | Standard deviation | alpha: α, beta: β |

**Formulas:**
- Mean = α / (α + β)
- SD = sqrt(αβ / ((α+β)²(α+β+1)))

**Example:**
```javascript
beta_mean(156, 244)    // Returns 0.39
beta_sd(156, 244)      // Returns 0.024
```

#### Lognormal Distribution

| Function | Description | Parameters |
|----------|-------------|------------|
| `lognormal_mean(mu, sigma)` | Mean of lognormal distribution | mu: log-mean, sigma: log-SD |
| `lognormal_sd(mu, sigma)` | Standard deviation | mu: log-mean, sigma: log-SD |

**Formulas:**
- Mean = exp(mu + sigma²/2)
- SD = sqrt((exp(sigma²) - 1) × exp(2×mu + sigma²))

### Discounting Functions

#### discount Function

```
discount(value, rate, time)
```

Calculates the present value of a future amount.

**Formula:** `value / (1 + rate)^time`

**Parameters:**
- `value`: Future value to discount
- `rate`: Annual discount rate (e.g., 0.035 for 3.5%)
- `time`: Time in years

**Example:**
```javascript
// Discount £10,000 at 3.5% for 5 years
discount(10000, 0.035, 5)  // Returns £8,420.73
```

#### discount_stream Function

```
discount_stream(annual_value, rate, years)
```

Calculates the present value of an annual stream of payments.

**Formula:** `annual_value × ((1 - (1 + rate)^(-years)) / rate)`

**Parameters:**
- `annual_value`: Annual payment amount
- `rate`: Annual discount rate
- `years`: Duration in years

**Example:**
```javascript
// Present value of £1,200 annually for 10 years at 3.5%
discount_stream(1200, 0.035, 10)  // Returns £10,010.88
```

### Aggregation Functions

| Function | Description | Example |
|----------|-------------|---------|
| `sum(a, b, ...)` | Sum of values | `sum(1, 2, 3)` → `6` |
| `mean(a, b, ...)` | Average of values | `mean(1, 2, 3)` → `2` |
| `product(a, b, ...)` | Product of values | `product(2, 3, 4)` → `24` |

## Practical Examples

### Example 1: Simple Discounted Lifetime Cost

```json
{
  "category": "lifetime_care",
  "value": {
    "expression": "acute_cost + discount_stream(annual_cost, 0.035, life_expectancy)",
    "description": "Acute cost plus discounted lifetime annual care costs at 3.5%"
  },
  "timing": "immediate"
}
```

### Example 2: Quality-Adjusted Life Years (QALYs)

```json
{
  "value": {
    "expression": "utility * discount_stream(1, 0.035, life_expectancy)",
    "description": "Discounted QALYs over remaining life expectancy"
  },
  "timing": "immediate"
}
```

### Example 3: Age-Dependent Costs

```json
{
  "value": {
    "expression": "if(age >= 65, elderly_care_cost, if(age >= 18, adult_care_cost, pediatric_care_cost))",
    "description": "Care cost varies by age group"
  },
  "timing": "annual"
}
```

### Example 4: Complex Stroke Model Cost

Based on your lifetime stroke model, calculating total lifetime costs:

```json
{
  "category": "lifetime_secondary_care",
  "value": {
    "expression": "acute_cost_mrs_0_1 + discount_stream(annual_cost_mrs_0_1, discount_rate_costs, life_expectancy_mrs_0_1) + (ed_attendance_count * ed_cost) + (non_elective_bed_days * non_elective_day_cost) + (elective_bed_days * elective_day_cost)",
    "description": "Total lifetime secondary care costs including acute, annual, ED, and bed days"
  },
  "timing": "immediate"
}
```

### Example 5: Probability with Uncertainty

```json
{
  "probability": {
    "expression": "if(use_psa_value, beta_mean(prob_alpha, prob_beta), prob_base_value)",
    "description": "Use PSA mean if in probabilistic mode, otherwise base value"
  }
}
```

### Example 6: Gompertz Survival Calculation

For complex survival models like yours:

```json
{
  "value": {
    "expression": "exp(-hazard_ratio_mrs * exp(gompertz_gamma * age) / gompertz_gamma)",
    "description": "Gompertz survival probability adjusted for mRS and age"
  }
}
```

### Example 7: Relative Risk Application

```json
{
  "probability": {
    "expression": "min(1, baseline_risk * relative_risk)",
    "description": "Apply relative risk with ceiling at 1.0"
  }
}
```

## Expression Validation

Implementations MUST validate expressions for:

### 1. Syntax Validation
- Correct operator usage
- Balanced parentheses
- Valid function names and argument counts
- No undefined operators

### 2. Semantic Validation
- All parameter names exist in the model's `parameters` section
- No circular references (parameter A's expression references parameter B, which references A)
- Function arguments match expected types
- Comparison operators used in boolean contexts

### 3. Type Checking
- Arithmetic operators receive numeric values
- Logical operators receive boolean values
- Function arguments are appropriate types

### 4. Bounds Checking
- Division by zero prevention
- Logarithms of non-positive numbers
- Square roots of negative numbers
- Discount rates between 0 and 1

## Error Handling

Expressions that fail validation MUST report:
1. The location of the error (character position if possible)
2. The type of error (syntax, undefined variable, type mismatch, etc.)
3. The specific issue (e.g., "Parameter 'xyz' not found", "Cannot divide by zero")

## Implementation Notes

### For Tool Developers

1. **Expression Parser**: Use an established expression parsing library (e.g., mathjs, expr-eval) rather than writing your own
2. **Security**: Never use `eval()` or similar dynamic code execution - use safe expression evaluators only
3. **Performance**: Cache parsed expressions to avoid re-parsing on each evaluation
4. **Debugging**: Provide clear error messages with context

### For Model Authors

1. **Keep It Simple**: Use the simplest expression that accomplishes your goal
2. **Document Complex Logic**: Always include a `description` field for non-trivial expressions
3. **Test Your Expressions**: Validate with known parameter values before deploying
4. **Avoid Deep Nesting**: Break complex calculations into intermediate parameters if needed

## Backward Compatibility

Models using schema v0.1.0 (parameter_ref only) remain valid. The `ValueReference` definition allows either:
- `{"parameter_ref": "param_id"}` (v0.1.0 style)
- `{"expression": "formula"}` (v0.1.1 style)

Tools should support both formats for maximum compatibility.

## Future Extensions

Potential additions in future versions:
- Array/vector operations for multi-state transitions
- Time-varying parameters (e.g., `param[t]`)
- Integration functions for continuous distributions
- Custom user-defined functions
- Matrix operations for complex state transitions

## References

- HTA Schema Technical Specification
- Mathematical Expression Evaluation Best Practices
- Health Economic Modeling Standards (ISPOR, NICE)
