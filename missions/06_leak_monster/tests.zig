const std = @import("std");
const mission = @import("mission");

test "leak monster summon duplicates the name and deinitializes" {
    var source = [_]u8{ 'g', 'o', 'b', 'l', 'i', 'n' };
    var monster = try mission.summon(std.testing.allocator, &source);
    defer monster.deinit(std.testing.allocator);

    source[0] = 'h';
    try std.testing.expectEqualStrings("goblin", monster.name);
}

test "leak monster roar returns uppercase plus bang" {
    var monster = try mission.summon(std.testing.allocator, "tiny beast");
    defer monster.deinit(std.testing.allocator);

    const output = try mission.roar(std.testing.allocator, monster);
    defer std.testing.allocator.free(output);

    try std.testing.expectEqualStrings("TINY BEAST!", output);
}

test "leak monster rejects empty names" {
    try std.testing.expectError(error.EmptyName, mission.summon(std.testing.allocator, ""));
}
