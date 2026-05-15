const std = @import("std");
const creatures = @import("lib.zig");

pub fn main() !void {
    var index = try creatures.parseIndex(std.heap.page_allocator, "{\"creatures\":[]}");
    defer index.deinit();

    std.debug.print("creatures: {d}\n", .{index.count()});
}
