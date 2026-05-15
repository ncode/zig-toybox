# Mission 08: JSON Creature Index

## Pitch

The creature index speaks JSON. Feed it a tiny bestiary and ask where the goblin sleeps.

## What you will build

A JSON-backed `Index` that parses `{ "creatures": [...] }`, counts creatures, and finds a habitat by exact name.

The starter compiles, but learner tests may fail until you replace the `error.Todo` gap. The maintained solution lives in `solution/src/`.

## What you will learn

- How `std.json.parseFromSlice` parses bytes into typed Zig structs.
- How parsed JSON owns allocated storage.
- How `deinit` releases parser-owned memory.

## Rules

- Use only the Zig standard library.
- Keep the schema tiny: `creatures`, `name`, and `habitat`.
- Return parser errors for malformed JSON; do not panic.
- `Index.deinit` must release parsed JSON storage.

## Run it

Run your learner version:

```sh
zig build run-08-json-creature-index
```

Run the maintained solution:

```sh
zig build run-08-json-creature-index-solution
```

## Test it

Run your learner tests:

```sh
zig build test-08-json-creature-index
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-08-json-creature-index-solution
zig build test
```

## Victory condition

Valid JSON becomes a queryable index, missing creatures return `null`, and malformed JSON returns an error.

## Boss mode

Reject duplicate creature names with your own error after parsing succeeds.

## Break it on purpose

Remove `defer index.deinit()` from a test. What leak does the testing allocator report?

## Reflection

- Which object owns the parsed strings?
- Why does `findHabitat` return `?[]const u8`?
- What changes if the JSON schema grows?
