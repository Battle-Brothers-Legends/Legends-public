this.legend_grappled_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendGrappled);
		this.m.Icon = "ui/perks/grapple_circle.png";
		this.m.IconMini = "mini_grapple";
		this.m.Overlay = "grapple_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been grappled to the ground and exhausted in the clinch. They will catch their breath in [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function getTooltip()
	{
		return [
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
				// Changed from fatigue to MD. Surprisingly the original didn't mention MD even though it had a whopping 50% MD debuff.
				text = "[color=%negative%]-12[/color] melee defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				// Changed from fatigue to init
				text = "[color=%negative%]-30%[/color] Initiative"
				//text = "[color=%negative%]-50%[/color] Maximum Fatigue"
			}
		];
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_87", this.getContainer().getActor().getTile());
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		// Very different in design document. Flat MD debuff and 30% initiative debuff.
		_properties.MeleeDefense -= 12;
		_properties.Initiative *= 0.7;

		// _properties.StaminaMult *= 0.5;
		// _properties.MeleeDefense *= 0.5;
		// _properties.FatigueRecoveryRate -= 20;

		if (!actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned))
		{
			actor.getSprite("status_stunned").setBrush("bust_dazed");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

