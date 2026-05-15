# Mission 09: Comptime Spellbook

## Pitch

The spellbook writes its own table at compile time. No heap, no registry, just enum fields turning into metadata.

## What you will build

A `Spell` enum, a generated `SpellInfo` table, and a lookup function for exact spell names.

The starter compiles, but learner tests may fail until you fill the empty table and null lookup. The maintained solution lives in `solution/src/`.

## What you will learn

- How `comptime` can generate static metadata.
- How enum declaration order can drive a table.
- How `std.meta.fields` exposes enum fields.

## Rules

- Use only the Zig standard library.
- Generate the table from `Spell`, not from three unrelated hand-written rows.
- Keep descriptions deterministic.
- `findSpell` returns `null` for unknown names.

## Run it

Run your learner version:

```sh
zig build run-09-comptime-spellbook
```

Run the maintained solution:

```sh
zig build run-09-comptime-spellbook-solution
```

## Test it

Run your learner tests:

```sh
zig build test-09-comptime-spellbook
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-09-comptime-spellbook-solution
zig build test
```

## Victory condition

The spell table has three entries in enum order, `mend` can be found, and unknown names return `null`.

## Boss mode

Add a compile-time check that every spell description is non-empty.

## Break it on purpose

Add a new enum tag without adding a description. What compile or test failure tells you the table drifted?

## Reflection

- What work happens at compile time here?
- Why is this simpler than a mutable command registry?
- When would runtime data be a better choice?
