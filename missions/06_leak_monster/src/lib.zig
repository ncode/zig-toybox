const std = @import("std");

pub const Monster = struct {
    name: []u8,

    pub fn deinit(self: *Monster, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
        self.name = &[_]u8{};
    }
};

pub fn summon(allocator: std.mem.Allocator, name: []const u8) !Monster {
    _ = allocator;
    _ = name;
    return error.Todo;
}

pub fn roar(allocator: std.mem.Allocator, monster: Monster) ![]u8 {
    _ = monster;
    return allocator.dupe(u8, "");
}
