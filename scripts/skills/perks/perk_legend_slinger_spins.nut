this.perk_legend_slinger_spins <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSlingerSpins);
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
		::logInfo("we're waiting");
		if (item != null && item.getID() == "weapon.legend_sling")
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendPrepareBullet);
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
