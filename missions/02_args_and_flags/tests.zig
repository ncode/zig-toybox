const std = @import("std");
const mission = @import("mission");

test "args and flags parses a name and renders a greeting" {
    const command = try mission.parse(&.{"Mira"});
    try std.testing.expectEqualStrings("Mira", command.name);
    try std.testing.expect(!command.shout);

    var buffer: [64]u8 = undefined;
    const greeting = try mission.renderGreeting(&buffer, command);
    try std.testing.expectEqualStrings("hello, Mira\n", greeting);
}

test "args and flags parses shout and renders uppercase" {
    const command = try mission.parse(&.{ "--shout", "Mira" });
    try std.testing.expectEqualStrings("Mira", command.name);
    try std.testing.expect(command.shout);

    var buffer: [64]u8 = undefined;
    const greeting = try mission.renderGreeting(&buffer, command);
    try std.testing.expectEqualStrings("HELLO, MIRA\n", greeting);
}

test "args and flags rejects unknown flags" {
    try std.testing.expectError(error.UnknownFlag, mission.parse(&.{ "--whisper", "Mira" }));
}

test "args and flags rejects missing names" {
    try std.testing.expectError(error.MissingName, mission.parse(&.{}));
    try std.testing.expectError(error.MissingName, mission.parse(&.{""}));
}

test "args and flags rejects too many names" {
    try std.testing.expectError(error.TooManyArguments, mission.parse(&.{ "Mira", "Niko" }));
}
