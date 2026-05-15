const std = @import("std");
const mission = @import("mission");

test "fortune goblin has three stable fortunes" {
    try std.testing.expectEqual(@as(usize, 3), mission.fortuneCount());
}

test "fortune goblin picks the first fortune" {
    try std.testing.expectEqualStrings("The goblin found a shiny slice.", mission.pickFortune(0));
}

test "fortune goblin wraps indexes" {
    try std.testing.expectEqualStrings("The goblin found a shiny slice.", mission.pickFortune(3));
}
