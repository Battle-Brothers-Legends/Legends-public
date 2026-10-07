::mods_hookExactClass("skills/effects/oath_of_endurance_completed_effect", function(ooece) {
    local getTooltip = ::mods_getMember(ooece, "getTooltip");
    local onUpdate = ::mods_getMember(ooece, "onUpdate");
    ::mods_overrideField(ooece, "FatigueBonus", 10);

    ::mods_override(ooece, "getTooltip", function() {
        local ret = getTooltip();
        ret.pop();

        ret.push({ id = 11, type = "text", icon = "ui/icons/special.png", text = "[color=" + Const.UI.Color.PositiveValue + "]+1[/color] Fatigue Recovery per turn" });

		return ret;
    });
});

::mods_hookExactClass("skills/actives/recover_skill", function(rs) {
	local getTooltip = ::mods_getMember(rs, "getTooltip");
	local onUse = ::mods_getMember(rs, "onUse");

	::mods_override(rs, "getTooltip", function() {
		local ret = getTooltip();

		// Undo tooltip changes
		if (getContainer().getActor().getSkills().hasSkill("effects.oath_of_endurance_completed")) {
			ret.pop();
			if (!isFirstSkillBeUsed())
				ret.pop();

			ret.push({ id = 7, type = "text", icon = "ui/icons/special.png", text = "Current Fatigue is reduced by [color=" + Const.UI.Color.PositiveValue + "]" + getRecoveredFat(getActionPointCost()) + "%[/color]" });

            if (!isFirstSkillBeUsed())
				ret.push({ id = 7, type = "text", icon = "ui/icons/warning.png", text = "[color=%negative%]Must be the first skill to be used on this character\'s turn[/color]" });
		}

		return ret;
	});

	::mods_override(rs, "onUse", function(_user, _targetTile) {
		onUse(_user, _targetTile);

		// Regardless of whether bro had the oath or not, just set fatigue to the correct amount
		_user.setFatigue(::Math.max(0, _user.getFatigue() - getRecoveredFat(m.UsedAP)));
	});
});