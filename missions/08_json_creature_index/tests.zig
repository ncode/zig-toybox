const std = @import("std");
const mission = @import("mission");

const valid_json =
    \\{
    \\  "creatures": [
    \\    { "name": "moth", "habitat": "cavern" },
    \\    { "name": "goblin", "habitat": "basement" }
    \\  ]
    \\}
;

test "json creature index parses and queries creatures" {
    var index = try mission.parseIndex(std.testing.allocator, valid_json);
    defer index.deinit();

    try std.testing.expectEqual(@as(usize, 2), index.count());
    try std.testing.expectEqualStrings("cavern", index.findHabitat("moth") orelse return error.MissingHabitat);
    try std.testing.expectEqualStrings("basement", index.findHabitat("goblin") orelse return error.MissingHabitat);
}

test "json creature index returns null for missing creature" {
    var index = try mission.parseIndex(std.testing.allocator, valid_json);
    defer index.deinit();

    try std.testing.expectEqual(@as(?[]const u8, null), index.findHabitat("dragon"));
}

test "json creature index rejects malformed json" {
    var index = mission.parseIndex(std.testing.allocator, "{ not json") catch |err| {
        if (std.mem.eql(u8, @errorName(err), "Todo")) return error.UnexpectedTodo;
        return;
    };
    index.deinit();
    return error.ExpectedMalformedJson;
}
