::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o)
{
	local original_onQueryUIElementTooltipData = o.onQueryUIElementTooltipData;

	function getColoredKeybindText(_keybindId)
	{
		local HexString = ::Legends.Mod.ModSettings.getSetting("obituary_hotkey_text_colour").getValueAsHexString();
		local colouredText = "[color=#" + HexString.slice(0, 6) + "]" + ::Legends.Mod.Keybinds.getKeybind(_keybindId).getKeyCombinationsCapitalized() + "[/color]";

		return colouredText;
	}

	local obituaryTooltips = {
		"world-screen.obituary.Level":          ["Level", "The level the character was upon meeting their fate."],
		"world-screen.obituary.Traits":         ["Traits", "The background and traits the character had upon meeting their fate."],
		"world-screen.obituary.PermInjuries":   ["Permanent Injuries", "The permanent injuries the character had upon meeting their fate."],
		"world-screen.obituary.Perks":          ["Perks", "The perks the character had upon meeting their fate."],
		"world-screen.obituary.HP":             ["Hitpoints", "The base hitpoints the character had upon meeting their fate."],
		"world-screen.obituary.FT":             ["Fatigue", "The base fatigue the character had upon meeting their fate."],
		"world-screen.obituary.BR":             ["Resolve", "The base resolve the character had upon meeting their fate."],
		"world-screen.obituary.IT":             ["Initiative", "The base initiative the character had upon meeting their fate."],
		"world-screen.obituary.MA":             ["Melee Skill", "The base melee skill the character had upon meeting their fate."],
		"world-screen.obituary.RA":             ["Ranged Skill", "The base ranged skill the character had upon meeting their fate."],
		"world-screen.obituary.MD":             ["Melee Defense", "The base melee defense the character had upon meeting their fate."],
		"world-screen.obituary.RD":             ["Ranged Defense", "The base ranged defense the character had upon meeting their fate."],
		"world-screen.obituary.swapperks":      ["Show Perks", "Swap the trait/permanent injuries columns for perks.\nHotkey: " + getColoredKeybindText("toggle_perks")],
		"world-screen.obituary.swapstats":      ["Swap Stat Order", "Swaps the position of first 4 stats (hp, fatigue, initiative, bravery) with the last 4 (attack / defense).\nHotkey: " + getColoredKeybindText("toggle_stat_order")],
		"world-screen.obituary.stackedstars":   ["Stacked Talent Stars", "Replace the 3 star talent icon (row of 3) with a triangle of stars.\nHotkey: " + getColoredKeybindText("stacked_talent_stars")]
	};

	function getObituaryStatTooltip(_elementId)
	{
		if (_elementId in obituaryTooltips)
		{
			local data = obituaryTooltips[_elementId];
			
			return [
				{ id = 1, type = "title", text = data[0] },
				{ id = 2, type = "description", text = data[1] }
			];
		}

		return null;
	}
	
	// Simple manual tooltip builder
	function BuildTooltip(skill, description = null)
	{
		local title = skill.getName();
		local descr = (description != null) ? description : skill.m.Description;

		local result = [
			{ id = 1, type = "title", text = title },
			{ id = 2, type = "description", text = descr }
		];

		return result;
	}

	o.onQueryUIElementTooltipData = function(_entityId, _elementId, _elementOwner)
	{
		// New Obituary header UI elements
		local statTooltip = getObituaryStatTooltip(_elementId);
		if (statTooltip != null)
		{
			return statTooltip;
		}
		
		if (!_elementId || _elementId == "" || _elementId.find("scripts/skills/") == null)
		{
			return original_onQueryUIElementTooltipData(_entityId, _elementId, _elementOwner);
		}

		local skill = ::new(_elementId);
		local desc;

		if (_elementId.find("background") != null)
		{
			desc = skill.m.BackgroundDescription;
			return BuildTooltip(skill, desc);
		}
		
		if (_elementId.find("trait") != null || _elementId.find("injury") != null)
		{
			// description overrides due to dynamic terms which we can't get due to a lack of an actor.
			if (_elementId.find("legend_arena_champion") != null)
				desc = "Every man and woman in the area stand secretly wants to be them, children play in streets dressed and fighting like they do. As they should.";
			else if (_elementId.find("legend_arena_invictus") != null)
				desc = "With a single fist raised, the stops crowd cheering. With both raised, they shout their name from the stands. Gladiators rather wrestle a Lindwurm than fight them in the arena.";
			else
				desc = skill.m.Description;

			return BuildTooltip(skill, desc);
		}
		
		// Legends has perks_def/perk_strings, which contains the full tooltip body, rather than a seperate Description.
		if (_elementId.find("perk") != null)
		{
			local perks = ::Const.Perks.PerkDefObjects.filter(@(_, _def) _def.Script == _elementId);

			if (perks.len() > 0)
			{
				desc = perks.top().Tooltip;
			}

			return BuildTooltip(skill, desc);
		}
		
		// Fallbacks that should be never be called, but just in case.
		foreach (fn in ["getTooltip", "getGenericTooltip"])
		{
			if (fn in skill && typeof skill[fn] == "function")
			{
				try
				{
					return skill[fn]();
				}
				catch (e)
				{
					::logError("Better Obituary: " + fn + "() failed: " + e);
				}
			}
		}

		return original_onQueryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	};
});
