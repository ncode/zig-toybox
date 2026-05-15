const std = @import("std");
const basement = @import("src/lib.zig");

test "hello basement greeting is stable" {
    try std.testing.expectEqualStrings("Hello from the basement.\n", basement.greeting());
}
