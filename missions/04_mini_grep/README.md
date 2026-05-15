# Mission 04: Mini Grep

## Pitch

The cave goblin wants only the lines containing its favorite word. No regex spellbook, just slices and literal bytes.

## What you will build

A tiny grep-like CLI that accepts `<pattern> <file>`, reads the file, and prints every line containing the literal pattern.

The starter compiles, but learner tests may fail until you replace the `error.Todo` gap. The maintained solution lives in `solution/src/`.

## What you will learn

- How to scan lines inside a byte slice.
- How to search with `std.mem.indexOf`.
- How file reading and owned output buffers make allocation visible.

## Rules

- Use only the Zig standard library.
- Do not use regex.
- Return a heap-owned output buffer from `filterMatches`.
- Reject an empty pattern with `error.EmptyPattern`.

## Run it

Run your learner version:

```sh
zig build run-04-mini-grep -- goblin missions/04_mini_grep/README.md
```

Run the maintained solution:

```sh
zig build run-04-mini-grep-solution -- goblin missions/04_mini_grep/README.md
```

## Test it

Run your learner tests:

```sh
zig build test-04-mini-grep
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-04-mini-grep-solution
zig build test
```

## Victory condition

`filterMatches` returns every matching line with one trailing newline per match, handles empty input, handles a final line without `\n`, and rejects an empty pattern.

## Boss mode

Rewrite the CLI to stream lines instead of reading the whole file at once.

## Break it on purpose

Remove the empty-pattern check. Why would every line suddenly match?

## Reflection

- Who owns the buffer returned by `filterMatches`?
- Why does the test free the returned slice?
- What changes when the final input line has no newline?
