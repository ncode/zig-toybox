const std = @import("std");

pub const Spell = enum { light, mend, vanish };

pub const SpellInfo = struct {
    spell: Spell,
    name: []const u8,
    description: []const u8,
};

pub fn spellTable() []const SpellInfo {
    return &[_]SpellInfo{};
}

pub fn findSpell(name: []const u8) ?SpellInfo {
    _ = name;
    return null;
}
