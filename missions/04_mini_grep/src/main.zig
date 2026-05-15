const std = @import("std");
const grep = @import("lib.zig");

pub fn main() !void {
    const output = try grep.filterMatches(std.heap.page_allocator, "", "todo");
    defer std.heap.page_allocator.free(output);
    std.debug.print("{s}", .{output});
}
