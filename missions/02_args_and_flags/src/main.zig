const std = @import("std");
const flags = @import("lib.zig");

pub fn main() !void {
    var buffer: [64]u8 = undefined;
    const greeting = try flags.renderGreeting(&buffer, .{ .name = "TODO", .shout = false });
    std.debug.print("{s}", .{greeting});
}
