# Mission 01: Fortune Goblin

## Pitch

The goblin owns three tiny prophecies. Your job is to pick one without losing track of the slice.

## What you will build

A small command-line program that prints a stable fortune. The starter compiles, but its count and fortune text are wrong until you finish the mission.

The maintained solution lives in `solution/src/` for comparison after you try the hints.

## What you will learn

- How fixed arrays become slices of string data.
- How deterministic indexing with `%` wraps around an array.
- How shared tests can check both learner and solution code.

## Rules

- Use only the Zig standard library and local imports.
- Keep exactly three stable fortunes.
- Do not allocate heap memory.
- Keep the CLI deterministic.

## Run it

Run your learner version:

```sh
zig build run-01-fortune-goblin
```

Run the maintained solution:

```sh
zig build run-01-fortune-goblin-solution
```

## Test it

Run your learner tests:

```sh
zig build test-01-fortune-goblin
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-01-fortune-goblin-solution
zig build test
```

## Victory condition

Your learner tests pass, `fortuneCount()` returns `3`, and index `3` wraps back to the first fortune.

## Boss mode

Add a fourth fortune, then update the tests and docs so the new behavior is deliberate instead of accidental.

## Break it on purpose

Change `% fortunes.len` to just `index`, then think about what happens when a caller asks for fortune `3`.

## Reflection

- Why does `pickFortune` return `[]const u8` instead of copying text?
- What does `%` protect you from here?
- Why is deterministic output useful while learning tests?
