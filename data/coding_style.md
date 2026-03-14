# Perl Coding Standard

## Indentation and Braces

- Whitesmiths indentation style with hard tabs (never spaces)
- `else` on its own line
- Named subs: opening brace `{` on line after `sub`, not indented; closing brace `}` not indented; code inside starts at first character with no indentation
- Anonymous subs:
  - Simple one-liners: `my $sub = sub { my ($x) = @_ ; return $x * 2 ; } ;`
  - Complex multi-line: opening `{` and closing `} ;` aligned under or in front of `sub` keyword, code inside fully indented
- Multi-line return: `return` alone, opening `(` on next line indented, values indented, closing `)` indented with space before `;`

## Function Calls

- No space between function name and opening parenthesis
- Opening brace, arguments, and closing brace on same line for single-line calls
- Space between closing parenthesis and semicolon
- Multi-line calls: opening `(` on its own line, arguments aligned under function name (indented to fall under the function), one argument per line with trailing comma, closing `)` indented

## Variables and Assignments

- `my` declaration and `= @_` on same line
- Sub arguments on same line as `sub`
- Related variables: group in single `my ($var1, $var2, $var3) = ...` declaration
- Empty array/hash: no need for `()`, just `my @array ;` or `my %hash ;`
- When declaring multiple empty variables, use `my ($var1, $var2) ;` construct
- Consecutive assignments on separate lines: align `=` signs vertically
- Newline after `my (...) = @_ ;` assignment from parameters

## Operators and Expressions

- Spaces around binary operators
- Hash/array access: no spaces inside braces/brackets: `$hash{key}` not `$hash{ key }`
- Ternary operator:
  - Single line if short: `my $x = $cond ? $true : $false ;`
  - Multi-line if condition is long: `?` and `:` heavily indented to stand out, aligned vertically
- String quoting: use single quotes unless interpolation needed

## Conditionals and Loops

- Always require parentheses in if/while/for conditions, except for postfix if/unless
- Postfix conditionals: no parentheses: `return $x if $x > 0 ;`
- Never use `foreach`, always use `for`
- `die` and `warn` without parentheses

## Regular Expressions

- Simple patterns: `/pattern/` not `m/pattern/`
- Complex multi-line patterns: `m/` on new line indented one tab under variable, pattern content at same indentation level, use `/x` modifier

## Hash and Array Declarations

- Up to 2 short elements on same line: `my %hash = (key1 => 'val1', key2 => 'val2') ;`
- Otherwise multi-line: opening `(` on new line, indented, closing `)` indented, trailing comma
- Nested hashes: inline if short `{ key => 'value' }`, multi-line if complex with opening `{` on new line
- Align `=>` operators when on consecutive lines

## Method Chaining

- Up to 2 chained calls on same line
- More than 2: break across lines, `->method()` indented to align under object variable

## Lists and Trailing Commas

- Multi-line lists: last element has trailing comma
- Single-line lists: no trailing comma on last element

## Spacing and Structure

- Space before semicolons at end of lines (always, including `use` statements)
- Newline before `return` statements (makes them pop out)
- Blank lines to separate logical blocks within subs
- Subs separated by: blank line + `# ------------------------------------------------------------------------------` + blank line
- No blank lines at start (after opening `{`) or end (before closing `}`) of subs

## Multi-line Construct Alignment Principle

**Core rule**: Argument lists, blocks, method chains, regex patterns, and all multi-line constructs are indented to align under the parent construct they apply to, creating visual hierarchy showing ownership/belonging.

## Comments and Clarity

- No numbers in comments unless asked for
- Minimize comments that add nothing to comprehension
- No end-of-function comments
- Never use icons or emojis
- High-level comments for complex blocks: use sparingly, only when code is too complex to understand quickly

## Module Imports

- `use strict ;` and `use warnings ;` with space before semicolon like all statements

## Mandatory Verification Process Before Presenting Code

1. Generate the code completely
2. Go through EVERY rule line-by-line systematically
3. Check each rule against the actual generated code
4. Fix any violations found
5. Only then present the code to the user

**NO EXCEPTIONS**: Every single rule must be applied. Never skip or ignore any rule for any reason. If you present code without verifying ALL rules, you are failing the task.

## Code Block Presentation

- Always present Perl code within ` ```perl ` markdown code blocks for proper formatting

---

**Perl Coding Standard additions**

- `use parent` for inheritance, not `use base`

**AST / API design**

- Remove redundant data: if a value is derivable from other fields already in the AST, do not include it as a separate field
- Large or optional output structures (grids, lookup tables, raw renders) are returned via separate accessors, not embedded in the primary return value
- Separate accessor methods for large data structures: `ast` returns the logical AST, `ast_grid` and `ast_cell_grid` return the supplementary data

**Script output formatting**

- Hard tabs for indentation in all script text output, not spaces
- Align related fields across lines to the same column (e.g. all `char=` values start at the same position, all `cell=` values start at the same position)
- This alignment rule applies within a logical group (e.g. all `from`/`to` lines within an edge block align together)
- Multi-item structures (e.g. path with more than one point) get their own indented block with a header keyword on its own line; single-item cases stay on one line
- Do not pad format strings in a way that introduces trailing whitespace on lines
- Columns widths in tabular output are computed dynamically from actual data, not hardcoded

**Dependencies**

- If a module is used anywhere in the distribution (scripts, optional features), it must be declared as a dependency in `Build.PL`

**Packaging**

- Tarballs must expand in place with no wrapping subdirectory
- Remove all build artifacts (`Build`, `_build/`, `blib/`, `MYMETA.*`) before packaging

---

# Markdown Formatting Standard

(Derived from Perl standard)

- Use `-` for list items, not `*`
- Don't bold first elements of list entries (no `**...**`)
- Minimize horizontal separators `---`
- No icons/emojis
- No numbers in comments unless asked
- Minimize unnecessary formatting
- don't wrap lines
- be concise
