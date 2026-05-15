# Mission 05: Hex Viewer

## Pitch

The hex oracle only speaks in bytes. Feed it a file and it shows both the numbers and the readable ghosts inside.

## What you will build

A binary-safe hex dump formatter that prints offsets, lowercase hex bytes, and an ASCII column wrapped in `|...|`.

The starter compiles, but learner tests may fail until you fill in the formatter. The maintained solution lives in `solution/src/`.

## What you will learn

- How bytes differ from text.
- How to format offsets and byte values with `std.fmt`.
- How to produce deterministic output for binary data.

## Rules

- Use only the Zig standard library.
- Format 8 bytes per line.
- Render printable ASCII bytes `0x20...0x7e` as themselves and all other bytes as `.`.
- Return a heap-owned dump string from `formatHex`.

## Run it

Run your learner version:

```sh
zig build run-05-hex-viewer -- missions/05_hex_viewer/README.md
```

Run the maintained solution:

```sh
zig build run-05-hex-viewer-solution -- missions/05_hex_viewer/README.md
```

## Test it

Run your learner tests:

```sh
zig build test-05-hex-viewer
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-05-hex-viewer-solution
zig build test
```

## Victory condition

`formatHex` returns an owned deterministic dump, handles empty input, formats binary bytes safely, and wraps at 8 bytes per line.

## Boss mode

Add an optional width parameter and update the tests so 8-byte output remains the default.

## Break it on purpose

Render raw bytes directly in the ASCII column. What happens to `0x00`, `0x7f`, or `0xff`?

## Reflection

- Why does the ASCII column replace some bytes with `.`?
- Why are offsets useful when inspecting binary files?
- Who frees the dump string returned by `formatHex`?
