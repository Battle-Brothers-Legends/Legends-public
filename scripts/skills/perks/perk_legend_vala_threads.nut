this.perk_legend_vala_threads <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendValaThreads);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}


	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive())
		{
			return;
		}

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() != "weapon.legend_staff_vala")
		{
			return true;
		}

		local expertise = this.getContainer().getActor().getBravery();
		local minimumHitChance = ::Legends.Mod.ModSettings.getSetting("MinimumChanceToHit").getValue();
		local maximumHitChance = ::Legends.Mod.ModSettings.getSetting("MaximumChanceToHit").getValue();
		expertise = this.Math.max(minimumHitChance, this.Math.min(maximumHitChance, expertise));

		if (this.Math.rand(1, 100) <= expertise)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_vala_threads_effect"));
			this.Sound.play("sounds/combat/legend_vala_threads.wav");
		}
	}
});
