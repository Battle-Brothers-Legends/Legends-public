this.legend_second_wind_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Counter = 3,
		ApplicableEffects = [
			::Legends.Effect.Stunned,
			::Legends.Effect.Dazed,
			::Legends.Effect.Staggered,
			::Legends.Effect.LegendBaffled,
			::Legends.Effect.Charmed,
			::Legends.Effect.Sleeping
		]
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSecondWind);
		this.m.Icon = "ui/perks/SecondWindPerk.png";
		this.m.IconMini = "mini_second_wind";
		this.m.Overlay = "perk_54_active";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has had a second wind and may not have another this combat.";
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Fatigue Recovery per turn for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Counter +"[/color] more turns"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 5;
	}

	function onTurnStart()
	{
		this.m.Counter -= 1;
		if (this.m.Counter >= 0)
			this.removeSelf();
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isAlive() || actor.isDying())
			return;
		actor.setFatigue(0);
		::Legends.Effects.grant(actor, ::Legends.Effect.RecoveryPotion);
		foreach (effect in this.m.ApplicableEffects)
		{
			if (this.getContainer().hasEffect(effect))
			{
				::Legends.Effects.remove(actor, effect);
			}
		}

		if (!actor.isHiddenToPlayer())
		{
			actor.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * actor.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
		}
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}
});

