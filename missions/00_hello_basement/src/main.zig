const std = @import("std");
const basement = @import("lib.zig");

pub fn main() void {
    std.debug.print("{s}", .{basement.greeting()});
}
