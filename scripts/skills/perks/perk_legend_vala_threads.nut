this.perk_legend_vala_threads <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaThreads);
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		local actor = this.getContainer().getActor();

		if (!::Legends.S.hasItemFlag(actor.getMainhandItem(), "vala_staff"))
			return;

		local expertise = actor.getBravery();
		local minimumHitChance = ::Legends.Mod.ModSettings.getSetting("MinimumChanceToHit").getValue();
		local maximumHitChance = ::Legends.Mod.ModSettings.getSetting("MaximumChanceToHit").getValue();
		expertise = this.Math.max(minimumHitChance, this.Math.min(maximumHitChance, expertise));

		if (this.Math.rand(1, 100) <= expertise)
		{
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendValaThreadsEffect);
			this.Sound.play("sounds/combat/legend_vala_threads.wav");
		}
	}
});
