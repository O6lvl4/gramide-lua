# gramide-lua 0.1.0

A separately buildable Lua 5.4 **structural reader** for gramide v0.2.11.
This is an original implementation based on the [Lua 5.4 reference manual](https://www.lua.org/manual/5.4/manual.html#9), not a vendored parser.

## Supported core

- Local bindings (including attribute syntax), assignments and calls
- Named/local/anonymous functions, parameters, varargs, dotted function names and colon methods
- Table constructors with positional, named and expression keys
- If/elseif/else, numeric/generic for, while, repeat/until, do blocks, break, labels and goto
- Prefix chains, indexing, calls with parentheses/string/table arguments, and Lua's expression precedence; power and concatenation are right associative
- Decimal/hex numerals and exponents; short quoted strings with Lua escapes; arbitrary-equals long strings and comments
- UTF-8 strings/comments are preserved without rewriting, with byte-based offsets and CRLF-aware coordinates

Named functions, local bindings and labels appear in symbols/outline/tags. Function names retain dots/colons as written. Global assignment targets are not inferred as declarations. Binding spans cover their names/attributes, not the complete local statement.

## Deliberate limits

Supported source line endings are LF and CRLF. Strict scanning rejects lone CR anywhere, including literals/comments, because the pinned engine otherwise gives inconsistent complete symbol line ranges. Byte offsets remain unchanged; recovery uses LF-based source coordinates.

This is not `luac`: scope/control-flow restrictions, const/close attribute validity, vararg context, goto legality and other semantic rules are not checked. Bare identifiers currently use the portable ASCII Lua identifier alphabet; locale-dependent non-ASCII identifiers are unsupported. Escape/numeral scanning does not check every implementation-specific numeric range. No broad upstream corpus or differential compiler campaign has been run.

Capabilities: `tokens`, `parse`, `outline`, `symbols`, `tags`, `map`. Neither `check` nor `symbols-recovered` is advertised. `symbols` requires the entire source to parse; `outline` may recover and is only a best-effort editing aid.

## Build and validate

```sh
almide test
almide build cli/main.almd -o gramide_lua
./gramide_lua gen-table | diff -u src/table.almd -
./gramide_lua symbols fixtures/module.lua
```

Regenerate the committed table with `./gramide_lua gen-table > src/table.almd` after editing the grammar, then rebuild. `src/mod.almd` imports only the generated table, never the grammar constructor. `src/fixture_test.almd` checks positive/negative fixtures, declaration names, and generated/dynamic tree equivalence. `ci/check.sh` also exercises CLI byte ranges and capability gates. The fixtures cover representative source, not a conformance claim.

## Repository contract

This repository owns this language package and its tests. `src/mod.almd` exports
`definition()` using the shared gramide package API. The `gramide-cli` repository
composes it as a git dependency; no grammar source is vendored into the CLI.
`bash ci/check.sh` runs the complete package gate with an explicit test entry
point, avoiding recursive parallel compiler fan-out. CI pins Almide and Rust
in `.github/workflows/quality.yml`.
