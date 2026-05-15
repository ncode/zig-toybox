const std = @import("std");

pub const Monster = struct {
    name: []u8,

    pub fn deinit(self: *Monster, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
        self.name = &[_]u8{};
    }
};

pub fn summon(allocator: std.mem.Allocator, name: []const u8) !Monster {
    if (name.len == 0) return error.EmptyName;

    const owned_name = try allocator.dupe(u8, name);
    errdefer allocator.free(owned_name);

    return .{ .name = owned_name };
}

pub fn roar(allocator: std.mem.Allocator, monster: Monster) ![]u8 {
    const output = try allocator.alloc(u8, monster.name.len + 1);
    for (monster.name, 0..) |byte, i| {
        output[i] = std.ascii.toUpper(byte);
    }
    output[output.len - 1] = '!';
    return output;
}
