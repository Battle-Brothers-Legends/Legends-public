::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o)
{
	local original_onQueryUIElementTooltipData = o.onQueryUIElementTooltipData;

	function getObituaryStatTooltip(_elementId)
	{
		if (_elementId in ::Legends.Obituary.Tooltip)
		{
			local data = ::Legends.Obituary.Tooltip[_elementId];

			return [
				{ id = 1, type = "title", text = data[0] },
				{ id = 2, type = "description", text = typeof data[1] == "function" ? data[1]() : data[1] }
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
			return statTooltip;

		if (typeof(_elementId) != "string" || _elementId.find("scripts/skills/") == null)
			return original_onQueryUIElementTooltipData(_entityId, _elementId, _elementOwner);

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
