const std = @import("std");
const hex = @import("lib.zig");

pub fn main() !void {
    const output = try hex.formatHex(std.heap.page_allocator, "");
    defer std.heap.page_allocator.free(output);
    std.debug.print("{s}", .{output});
}
