this.legend_rune <- this.inherit("scripts/crafting/blueprint", {
	m = {
		Rune = 0,
	},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "";
		local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
		token.setRuneVariant(this.m.Rune);
		token.updateRuneSigilToken();
		token.getRuneSigilTooltip = this.getRuneSigilTooltip;
		this.m.PreviewCraftable = token;
		this.m.Cost = 1200;
		this.m.Enchanter = true;
		local ingredients = [
			{
				Script = "scripts/items/trade/uncut_gems_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/legend_vala_background"]
			}
		]
		this.initSkills(skills);
	}

	function isUpgraded()
	{
		return this.Stash.hasItem("tent.enchant_tent");
	}

	function getRuneSigilTooltip()
	{
		local max1 = 0;
		local max2 = 0;

		switch (this.m.Rune)
		{
			case 1:
				max1 = this.isUpgraded() ? 9 : 6;
				max2 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Power:\n[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] total damage inflicted and [color=" + this.Const.UI.Color.PositiveValue + "]+3 to +" + max2 + "%[/color] maximum damage.";
				break;

			case 2:
				max1 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Accuracy:\n[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Melee skill.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Ranged skill.";
				break;

			case 3:
				max1 = this.isUpgraded() ? 6 : 4;
				return "This item has the power of the rune sigil of Feeding:\n[color=" + this.Const.UI.Color.PositiveValue + "]2% to " + max1 + "%[/color] of inflicted health damage recovers fatigue.";
				break;

			case 4:
				max1 = this.isUpgraded() ? 3 : 2;
				max2 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Poison:\n[color=" + this.Const.UI.Color.PositiveValue + "]1 to " + max1 + "[/color] turn(s) of poison applied, with a strength of [color=" + this.Const.UI.Color.PositiveValue + "]3 to " + max2 + "[/color]. Lowers action points and initiative.";
				break;

			case 5:
				max1 = this.isUpgraded() ? 9 : 6;
				max2 = this.isUpgraded() ? 3 : 2;
				return "This item has the power of the rune sigil of Bleeding:\n[color=" + this.Const.UI.Color.PositiveValue + "]3 to " + max1 + "[/color] bleed damage every turn for [color=" + this.Const.UI.Color.PositiveValue + "]1 to " + max2 + "[/color] turn(s).";
				break;

			case 6:
				max1 = this.isUpgraded() ? 3 : 2;
				max2 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Unbreaking:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + max1 + "[/color] to [color=" + this.Const.UI.Color.PositiveValue + "]" + max2 + "[/color] durability restored on every kill.";
				break;

			case 11:
				max1 = this.isUpgraded() ? 2 : 1;
				max2 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Clarity:\n[color=" + this.Const.UI.Color.PositiveValue + "]0 to +" + max1 + "[/color] Vision.\n[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max2 + "%[/color] Experience gain.";
				break;

			case 12:
				max1 = this.isUpgraded() ? 9 : 6;
				max2 = this.isUpgraded() ? 5 : 3;
				return "This item has the power of the rune sigil of Bravery:\n[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Resolve.\n [color=" + this.Const.UI.Color.PositiveValue + "]+1 to +" + max2 + "[/color] Resolve at all morale checks.";
				break;

			case 13:
				max1 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Luck:\n[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
				break;

			case 21:
				max1 = this.isUpgraded() ? 3 : 1;
				max2 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Endurance:\n[color=" + this.Const.UI.Color.PositiveValue + "]+0 to +" + max1 + "[/color] Fatigue recovery per turn.\n[color=" + this.Const.UI.Color.PositiveValue + "]-3% to -" + max2 + "%[/color] Fatigue cost and effects multiplier.";
				break;

			case 22:
				max1 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Safety:\n[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Hitpoints.\n[color=" + this.Const.UI.Color.PositiveValue + "]-3% to -" + max1 + "%[/color] Damage received.";
				break;

			// case 23: //Removed 22/1/23 as part of the steel brow rework. May rework this rune in a similar manner later where its not blanket immunity
			// 	return "This item has the power of the rune sigil of Resilience:\n[color=" + this.Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs.";
			// 	break;

			case 31:
				max1 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Defense:\n[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Melee defense.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+3% to +" + max1 + "%[/color] Ranged defense.";
				break;

			case 32:
				max1 = this.isUpgraded() ? 9 : 6;
				return "This item has the power of the rune sigil of Radiance:\n[color=" + this.Const.UI.Color.PositiveValue + "]-3% to -" + max1 + "%[/color] to all adjacent enemies\' Melee skill.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]-3% to -" + max1 + "%[/color] to all adjacent enemies\' Melee defense.";
				break;

			default:
				return "This item is inscribed with a rune sigil, even though it shouldn't have been: please report this bug.";
				break;
		}
	}

	function onEnchant( _stash, _bonus )
	{
		if (this.m.Rune == 11 || this.m.Rune == 12 || this.m.Rune == 13 || this.m.Rune == 21 || this.m.Rune == 22 || this.m.Rune == 23)
		{
			local rune;
			switch (this.m.Rune)
			{
				case 11:
				rune = this.new("scripts/items/legend_helmets/runes/legend_rune_clarity");
				break;

				case 12:
				rune = this.new("scripts/items/legend_helmets/runes/legend_rune_bravery");
				break

				case 13:
				rune = this.new("scripts/items/legend_helmets/runes/legend_rune_luck");
				break

				case 21:
				rune = this.new("scripts/items/legend_armor/runes/legend_rune_endurance");
				break;

				case 22:
				rune = this.new("scripts/items/legend_armor/runes/legend_rune_safety");
				break

				// case 23: //Removed 22/1/23 as part of the steel brow rework. May rework this rune in a similar manner later where its not blanket immunity
				// rune = this.new("scripts/items/legend_armor/runes/legend_rune_resilience");
				// break
			}
			rune.setRuneVariant(this.m.Rune);
			rune.setRuneBonus(_bonus);
			rune.setRuneVariant(0);
			//rune.updateRuneSigilToken();
			_stash.add(rune);
		}
		else
		{
			local rune =  this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
			rune.setRuneVariant(this.m.Rune);
			rune.setRuneBonus(_bonus);
			rune.updateRuneSigilToken();
			_stash.add(rune);
		}
	}
});
