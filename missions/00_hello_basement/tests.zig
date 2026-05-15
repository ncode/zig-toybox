const std = @import("std");
const mission = @import("mission");

test "hello basement greeting is stable" {
    try std.testing.expectEqualStrings("Hello from the basement.\n", mission.greeting());
}
