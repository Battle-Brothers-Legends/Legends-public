this.perk_legend_slinger_spins <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_slinger_spins";
		this.m.Name = this.Const.Strings.PerkName.LegendSlingerSpins;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSlingerSpins;
		this.m.Icon = "ui/perks/sling_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onWaitTurn()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		if (item != null && (item.getID() == "weapon.named_sling" || item.getID() == "weapon.legend_sling"))
			actor.getSkills().add(this.new("scripts/skills/effects/legend_slinger_spins_effect"));
	}

	// only makes sense on wait turn
	// function onTurnEnd()
	// {
	// 	local actor = this.getContainer().getActor();
	// 	local item = actor.getMainhandItem();
	// 	if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Sling))
	// 		actor.getSkills().add(this.new("scripts/skills/effects/slinger_spins_effect"));
	// }
});
