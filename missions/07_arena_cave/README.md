# Mission 07: Arena Cave

## Pitch

The arena cave collapses all allocations at once. Parse a batch of creatures, then let one `deinit` seal the tunnel.

## What you will build

A parser for `name:habitat` records, one creature per line. It returns a slice of `Creature` values whose names and habitats are owned by an arena allocator.

The starter compiles, but learner tests may fail until you replace the `error.Todo` gap. The maintained solution lives in `solution/src/`.

## What you will learn

- How an arena allocator fits short-lived batch parsing.
- How owned slices can point into allocator-owned memory.
- How callers free arena-backed data by deinitializing the arena.

## Rules

- Use only the Zig standard library.
- Parse records shaped `name:habitat`.
- Reject missing colons, empty names, and empty habitats with `error.InvalidRecord`.
- Do not free individual creature fields; the arena owns the batch.

## Run it

Run your learner version:

```sh
zig build run-07-arena-cave
```

Run the maintained solution:

```sh
zig build run-07-arena-cave-solution
```

## Test it

Run your learner tests:

```sh
zig build test-07-arena-cave
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-07-arena-cave-solution
zig build test
```

## Victory condition

The parser returns the expected creatures, rejects malformed lines, and needs only `arena.deinit()` for cleanup.

## Boss mode

Allow blank lines between records without changing ownership rules.

## Break it on purpose

Return slices pointing into the original input instead of duplicating fields. What happens if the input buffer changes?

## Reflection

- Why is an arena a good fit for this batch parser?
- When would an arena be the wrong allocator choice?
- Which value owns the copied creature names?
