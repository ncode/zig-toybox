const std = @import("std");
const goblin = @import("lib.zig");

pub fn main() void {
    std.debug.print("{s}\n", .{goblin.pickFortune(0)});
}
