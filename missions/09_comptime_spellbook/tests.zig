const std = @import("std");
const mission = @import("mission");

test "comptime spellbook exposes enum-ordered table" {
    const table = mission.spellTable();

    try std.testing.expectEqual(@as(usize, 3), table.len);
    try std.testing.expectEqual(mission.Spell.light, table[0].spell);
    try std.testing.expectEqualStrings("light", table[0].name);
}

test "comptime spellbook finds mend" {
    const info = mission.findSpell("mend") orelse return error.MissingSpell;

    try std.testing.expectEqual(mission.Spell.mend, info.spell);
    try std.testing.expectEqualStrings("patch the tiny robe", info.description);
}

test "comptime spellbook returns null for unknown spell" {
    try std.testing.expectEqual(@as(?mission.SpellInfo, null), mission.findSpell("explode"));
}
