const std = @import("std");

pub const Spell = enum { light, mend, vanish };

pub const SpellInfo = struct {
    spell: Spell,
    name: []const u8,
    description: []const u8,
};

const table = buildSpellTable();

pub fn spellTable() []const SpellInfo {
    return &table;
}

pub fn findSpell(name: []const u8) ?SpellInfo {
    for (spellTable()) |info| {
        if (std.mem.eql(u8, info.name, name)) return info;
    }
    return null;
}

fn buildSpellTable() [std.meta.fields(Spell).len]SpellInfo {
    const fields = std.meta.fields(Spell);
    var result: [fields.len]SpellInfo = undefined;
    for (fields, 0..) |field, i| {
        result[i] = .{
            .spell = @field(Spell, field.name),
            .name = field.name,
            .description = descriptionFor(@field(Spell, field.name)),
        };
    }
    return result;
}

fn descriptionFor(spell: Spell) []const u8 {
    return switch (spell) {
        .light => "glow without a heap allocation",
        .mend => "patch the tiny robe",
        .vanish => "leave only a stack trace",
    };
}
