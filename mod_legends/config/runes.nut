::Legends.Rune <- {}

::Legends.Runes <- {
	Defs = {},
	add = function(_def) {
		local id = ::Legends.Rune.len() + 1;
		::Legends.Runes.Defs[id] <- _def;
		return id;
	}
	get = function(_const) {
		return ::Legends.Runes.Defs[_const];
	}
};

/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRswPower <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Weapon,
	Name = "Weapon Rune Sigil: Power",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswPower,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Power:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "%[/color] Damage inflicted.\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus2() + "[/color] Max damage.";
	},
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Power:\n[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] total damage inflicted and [color=" + ::Const.UI.Color.PositiveValue + "]+3 to +" + max2 + "%[/color] maximum damage.";
	}
});


::Legends.Rune.LegendRswAccuracy <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Weapon,
	Name = "Weapon Rune Sigil: Accuracy",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswAccuracy,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Accuracy:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "%[/color] Melee skill.\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus2() + "%[/color] Ranged skill.";
	},
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Accuracy:\n[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Melee skill.\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Ranged skill.";
	}
});

::Legends.Rune.LegendRswFeeding <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Weapon,
	Name = "Weapon Rune Sigil: Feeding",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswFeeding,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(2, 6));
		} else {
			_item.setRuneBonus1(::Math.rand(2, 4));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Feeding:\n[color=" + ::Const.UI.Color.PositiveValue + "]" + _item.getRuneBonus1() + "%[/color] of inflicted health damage recovers fatigue.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 6 : 4;
		return "This item has the power of the rune sigil of Feeding:\n[color=" + ::Const.UI.Color.PositiveValue + "]2% to " + max1 + "%[/color] of inflicted health damage recovers fatigue.";
	}
});

::Legends.Rune.LegendRswPoison <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Weapon,
	Name = "Weapon Rune Sigil: Poison",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswPoison,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(1, 3));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(1, 2));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Poison:\n[color=" + ::Const.UI.Color.PositiveValue + "]" + _item.getRuneBonus1() + "[/color] turn(s) of poison applied, with a strength of [color=" + ::Const.UI.Color.PositiveValue + "]" + _item.getRuneBonus2() + "[/color]. Lowers action points and initiative.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 3 : 2;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Poison:\n[color=" + ::Const.UI.Color.PositiveValue + "]1 to " + max1 + "[/color] turn(s) of poison applied, with a strength of [color=" + ::Const.UI.Color.PositiveValue + "]3 to " + max2 + "[/color]. Lowers action points and initiative.";
	}
});

::Legends.Rune.LegendRswBleeding <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Weapon,
	Name = "Weapon Rune Sigil: Bleeding",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswBleeding,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Bleeding:\n[color=" + ::Const.UI.Color.PositiveValue + "]" + _item.getRuneBonus1() + "[/color] bleed damage every turn for [color=" + ::Const.UI.Color.PositiveValue + "]" + _item.getRuneBonus2() + "[/color] turn(s).";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		local max2 = _item.isUpgraded() ? 3 : 2;
		return "This item has the power of the rune sigil of Bleeding:\n[color=" + ::Const.UI.Color.PositiveValue + "]3 to " + max1 + "[/color] bleed damage every turn for [color=" + ::Const.UI.Color.PositiveValue + "]1 to " + max2 + "[/color] turn(s).";
	}
});

::Legends.Rune.LegendRswUnbreaking <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Weapon,
	Name = "Weapon Rune Sigil: Unbreaking",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswUnbreaking,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Unbreaking:\n[color=" + ::Const.UI.Color.PositiveValue + "]" + _item.getRuneBonus1() + "[/color] to [color=" + ::Const.UI.Color.PositiveValue + "]" + _item.getRuneBonus2() + "[/color] durability restored on every kill.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 3 : 2;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Unbreaking:\n[color=" + ::Const.UI.Color.PositiveValue + "]" + max1 + "[/color] to [color=" + ::Const.UI.Color.PositiveValue + "]" + max2 + "[/color] durability restored on every kill.";
	}
});

::Legends.Rune.LegendRshClarity <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Helmet,
	Name = "Helmet Rune Sigil: Clarity",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshClarity,
	Script = "scripts/items/legend_helmets/runes/legend_rune_clarity",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(0, 2));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(0, 1));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Clarity:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "[/color] Vision.\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus2() + "%[/color] Experience gain.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 2 : 1;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Clarity:\n[color=" + ::Const.UI.Color.PositiveValue + "]0 to +" + max1 + "[/color] Vision.\n[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max2 + "%[/color] Experience gain.";
	}
});

::Legends.Rune.LegendRshBravery <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Helmet,
	Name = "Helmet Rune Sigil: Bravery",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshBravery,
	Script = "scripts/items/legend_helmets/runes/legend_rune_bravery",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 5));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 3));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Bravery:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "%[/color] Resolve.\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus2() + "[/color] Resolve at all morale checks.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		local max2 = _item.isUpgraded() ? 5 : 3;
		return "This item has the power of the rune sigil of Bravery:\n[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Resolve.\n [color=" + ::Const.UI.Color.PositiveValue + "]+1 to +" + max2 + "[/color] Resolve at all morale checks.";
	}
});

::Legends.Rune.LegendRshLuck <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Helmet,
	Name = "Helmet Rune Sigil: Luck",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshLuck,
	Script = "scripts/items/legend_helmets/runes/legend_rune_luck",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Luck:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Luck:\n[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
	}
});

::Legends.Rune.LegendRsaEndurance <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Armor,
	Name = "Armor Rune Sigil: Endurance",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaEndurance,
	Script = "scripts/items/legend_armor/runes/legend_rune_endurance",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(0, 3));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(0, 1));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Endurance:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "[/color] Fatigue recovery per turn.\n[color=" + ::Const.UI.Color.PositiveValue + "]-" + _item.getRuneBonus2() + "%[/color] Fatigue cost and effects multiplier.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 3 : 1;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Endurance:\n[color=" + ::Const.UI.Color.PositiveValue + "]+0 to +" + max1 + "[/color] Fatigue recovery per turn.\n[color=" + ::Const.UI.Color.PositiveValue + "]-3% to -" + max2 + "%[/color] Fatigue cost and effects multiplier.";
	}
});

::Legends.Rune.LegendRsaSafety <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Armor,
	Name = "Armor Rune Sigil: Safety",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaSafety,
	Script = "scripts/items/legend_armor/runes/legend_rune_safety",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Safety:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "%[/color] Hitpoints.\n[color=" + ::Const.UI.Color.PositiveValue + "]-" + _item.getRuneBonus2() + "%[/color] Damage received.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Safety:\n[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Hitpoints.\n[color=" + ::Const.UI.Color.PositiveValue + "]-3% to -" + max1 + "%[/color] Damage received.";
	}
});

::Legends.Rune.LegendRsaResilience <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Armor,
	Name = "Armor Rune Sigil: Resilience",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaResilience,
	Script = "scripts/items/legend_armor/runes/legend_rune_resilience",
	setRuneBonus = function(_item, _bonus) {},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Resilience:\n[color=" + ::Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs.";
	}
	getRuneTooltip = function (_item) {
		// Removed 22/1/23 as part of the steel brow rework. May rework this rune in a similar manner later where its not blanket immunity
		// return "This item has the power of the rune sigil of Resilience:\n[color=" + this.Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs.";
		return "This rune is not supposed to drop, if you see this, post bug report."
	}
});

::Legends.Rune.LegendRssDefense <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Shield,
	Name = "Shield Rune Sigil: Defense",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssDefense,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Defense:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus1() + "%[/color] Melee defense.\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]+" + _item.getRuneBonus2() + "%[/color] Ranged defense.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Defense:\n[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Melee defense.\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Ranged defense.";
	}
});

::Legends.Rune.LegendRssRadiance <- ::Legends.Runes.add({
	ItemType = ::Const.Items.ItemType.Shield,
	Name = "Shield Rune Sigil: Radiance",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssRadiance,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 12));
			_item.setRuneBonus2(::Math.rand(3, 12));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Radiance:\n[color=" + ::Const.UI.Color.PositiveValue + "]-" + _item.getRuneBonus1() + "%[/color] to all adjacent enemies\' Melee skill.\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]-" + _item.getRuneBonus2() + "%[/color] to all adjacent enemies\' Melee defense.";
	}
	getRuneTooltip = function (_item) {
		max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Radiance:\n[color=" + ::Const.UI.Color.PositiveValue + "]-3% to -" + max1 + "%[/color] to all adjacent enemies\' Melee skill.\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]-3% to -" + max1 + "%[/color] to all adjacent enemies\' Melee defense.";
	}
});



