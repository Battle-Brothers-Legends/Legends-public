::mods_hookExactClass("items/shields/buckler_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A small but sturdy shield gripped in the fist. Offers poor protection against ranged attacks but can be useful in deflecting blows in melee. Gains defense depending on how many enemies are within 1 tile.";
		this.m.MeleeDefense = 5;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_buckler_bash_skill"));
		
		local effect = this.new("scripts/skills/effects/legend_buckler_effect");
		effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
		effect.setItem(this);
		this.m.SkillPtrs.push(effect);
		this.getContainer().getActor().getSkills().add(effect);

		local ambidex = this.getContainer().getActor().getSkills().getSkillByID("perk.legend_ambidextrous");
		if (ambidex)
			ambidex.setOffhandSkill("actives.legend_buckler_bash");
	}

	o.onUnequip <- function()
	{
		shield.onUnequip();
		local ambidex = this.getContainer().getActor().getSkills().getSkillByID("perk.legend_ambidextrous");
		if (ambidex)
			ambidex.resetOffhandSkill();
	}
});
