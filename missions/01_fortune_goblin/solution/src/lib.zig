const std = @import("std");

const fortunes = [_][]const u8{
    "The goblin found a shiny slice.",
    "Allocators prefer clear ownership.",
    "A test watched the bug crawl out.",
};

pub fn fortuneCount() usize {
    _ = std;
    return fortunes.len;
}

pub fn pickFortune(index: usize) []const u8 {
    return fortunes[index % fortunes.len];
}
