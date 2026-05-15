const std = @import("std");
const spellbook = @import("lib.zig");

pub fn main() void {
    for (spellbook.spellTable()) |spell| {
        std.debug.print("{s}: {s}\n", .{ spell.name, spell.description });
    }
}
