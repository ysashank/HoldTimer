---
applyTo: '**'
---

## Scope
Only modify what was explicitly requested. Never make additional changes.

## File Headers
Update header date to current date only when creating or modifying functional code.

## Data & Configuration
Swift-native only. No JSON, no external data formats. Maintain compile-time type safety.

## Error Handling
Never surface technical errors to users. Fail silently. Degrade gracefully. No alerts for things users cannot fix.

## Service Patterns
Enum for stateless utilities. Singleton for system resources or global app state. Instance-based for per-view state.

## Architecture
Strictly MVVM.

## Code Style
Must be in the most concise form possible.

No backwards compatibility. No legacy patterns. No workarounds for old iOS versions. Only forward-looking. Dead code must be removed immediately. No commented-out code. No TODOs. No hacks. No workarounds. No temporary fixes.

## Comments
Swift standard library style. Only for non-obvious code. No comments for self-explanatory code. No comments for things that can be easily inferred from context.