::mods_hookExactClass("items/shields/buckler_shield", function(o) {
	o.m.PrimaryOffhandAttack <- null;

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
		local bash = this.new("scripts/skills/actives/legend_buckler_bash_skill");
		m.PrimaryOffhandAttack = ::MSU.asWeakTableRef(bash);
		this.addSkill(bash);
		
		local effect = this.new("scripts/skills/effects/legend_buckler_effect");
		effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
		effect.setItem(this);
		this.m.SkillPtrs.push(effect);
		this.getContainer().getActor().getSkills().add(effect);
	}

	o.onUnequip <- function()
	{
		shield.onUnequip();
		m.PrimaryOffhandAttack = null;
	}

	o.getPrimaryOffhandAttack <- function()
	{
		return m.PrimaryOffhandAttack;
	}
});
