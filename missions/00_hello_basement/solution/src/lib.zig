const std = @import("std");

pub fn greeting() []const u8 {
    _ = std;
    return "Hello from the basement.\n";
}
