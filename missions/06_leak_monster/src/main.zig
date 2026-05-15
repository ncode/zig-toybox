const std = @import("std");
const leak = @import("lib.zig");

pub fn main() !void {
    var monster = try leak.summon(std.heap.page_allocator, "TODO");
    defer monster.deinit(std.heap.page_allocator);

    const output = try leak.roar(std.heap.page_allocator, monster);
    defer std.heap.page_allocator.free(output);

    std.debug.print("{s}\n", .{output});
}
