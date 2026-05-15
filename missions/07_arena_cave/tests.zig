const std = @import("std");
const mission = @import("mission");

test "arena cave parses two creatures" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const creatures = try mission.parseCreatures(arena.allocator(), "moth:cavern\ngoblin:basement\n");

    try std.testing.expectEqual(@as(usize, 2), creatures.len);
    try std.testing.expectEqualStrings("moth", creatures[0].name);
    try std.testing.expectEqualStrings("cavern", creatures[0].habitat);
    try std.testing.expectEqualStrings("goblin", creatures[1].name);
    try std.testing.expectEqualStrings("basement", creatures[1].habitat);
}

test "arena cave handles empty input" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const creatures = try mission.parseCreatures(arena.allocator(), "");

    try std.testing.expectEqual(@as(usize, 0), creatures.len);
}

test "arena cave rejects malformed records" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    try std.testing.expectError(error.InvalidRecord, mission.parseCreatures(arena.allocator(), "moth\n"));
    try std.testing.expectError(error.InvalidRecord, mission.parseCreatures(arena.allocator(), ":cavern\n"));
    try std.testing.expectError(error.InvalidRecord, mission.parseCreatures(arena.allocator(), "moth:\n"));
}
