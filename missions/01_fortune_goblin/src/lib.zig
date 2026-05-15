const std = @import("std");

pub fn fortuneCount() usize {
    _ = std;
    return 1;
}

pub fn pickFortune(index: usize) []const u8 {
    _ = index;
    return "The goblin is still digging.";
}
