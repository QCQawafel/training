# Gherkin Style Guide

Keep scenarios clear, observable, and executable.

## Principles

1. Write behaviour, not implementation noise.
2. Make preconditions explicit.
3. Make outcomes observable.
4. Keep one coherent behaviour per scenario.
5. Use language the team already understands.

## Structure

- `Given`: context and preconditions
- `When`: actions
- `Then`: expected outcomes
- `And`: additional details that extend the same idea

## Good Practices

- State language or environment assumptions when they matter.
- Name pages, headings, buttons, and fields clearly.
- Prefer visible outcomes such as redirects, headings, validation messages, or list changes.
- Include cleanup only when the scenario creates state and cleanup matters.

## Anti-patterns

- `Then it works`
- `Then an error appears`
- Missing login or page context
- Unstated language assumptions
- Low-level click-by-click instructions when a clearer action is possible
- Multiple unrelated behaviours in one scenario

## Example: Better vs Worse

### Worse

```gherkin
Scenario: Edit sample
  Given I am logged in
  When I edit the sample
  Then it works
```

### Better

```gherkin
Scenario: Edit sample with invalid stock value
  Given I am logged in to the app as mobile number "555555555" with OTP "201111"
  And the app language is set to Arabic
  And I am on the samples tab
  When I clear the "المخزون من العينة" (Sample Stock) field
  And I click the "حفظ التغيرات" (Save Changes) button
  Then the sample should not be saved
  And I should see a clear, user-friendly validation message indicating that sample stock is required
```

## Review Standard

A scenario does not need to match the canonical wording exactly.

It does need to be:

- clear enough for a human to follow;
- clear enough for an agent to execute;
- specific enough to verify the outcome.