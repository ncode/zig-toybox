# Mission 06: Leak Monster

## Pitch

The leak monster grows every time you forget who owns memory. Summon it, make it roar, then clean up after it.

## What you will build

A tiny heap-owning `Monster` type. `summon` duplicates a name, `roar` returns an owned uppercase roar, and callers must free both pieces.

The starter compiles, but learner tests may fail until you replace the `error.Todo` gap. The maintained solution lives in `solution/src/`.

## What you will learn

- How allocators make ownership explicit.
- How `defer` pairs allocation with cleanup.
- How `errdefer` protects partially-built owned values.

## Rules

- Use only the Zig standard library.
- `summon` must reject empty names with `error.EmptyName`.
- `Monster.deinit` frees the heap-owned name.
- `roar` returns a heap-owned string that the caller frees.

## Run it

Run your learner version:

```sh
zig build run-06-leak-monster
```

Run the maintained solution:

```sh
zig build run-06-leak-monster-solution
```

## Test it

Run your learner tests:

```sh
zig build test-06-leak-monster
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-06-leak-monster-solution
zig build test
```

## Victory condition

The tests pass with `std.testing.allocator`, which means the monster name and roar output are both freed correctly.

## Boss mode

Add a `title` field that is also heap-owned, then use `errdefer` so a failed second allocation does not leak the first one.

## Break it on purpose

Comment out one `defer` in a test or the CLI. What leak does Zig report?

## Reflection

- Why does `summon` duplicate the name instead of storing the input slice?
- Why does `roar` allocate a new buffer?
- What does `deinit` promise to the caller?
