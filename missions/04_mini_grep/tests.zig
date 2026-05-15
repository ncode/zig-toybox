const std = @import("std");
const mission = @import("mission");

test "mini grep finds matching lines in multi-line input" {
    const output = try mission.filterMatches(
        std.testing.allocator,
        "goblin hoard\nquiet cave\ngoblin snack\n",
        "goblin",
    );
    defer std.testing.allocator.free(output);

    try std.testing.expectEqualStrings("goblin hoard\ngoblin snack\n", output);
}

test "mini grep handles no match as owned empty string" {
    const output = try mission.filterMatches(std.testing.allocator, "alpha\nbeta\n", "goblin");
    defer std.testing.allocator.free(output);

    try std.testing.expectEqualStrings("", output);
}

test "mini grep handles final line without newline" {
    const output = try mission.filterMatches(std.testing.allocator, "alpha\ngoblin", "goblin");
    defer std.testing.allocator.free(output);

    try std.testing.expectEqualStrings("goblin\n", output);
}

test "mini grep rejects empty pattern" {
    try std.testing.expectError(
        error.EmptyPattern,
        mission.filterMatches(std.testing.allocator, "goblin\n", ""),
    );
}
