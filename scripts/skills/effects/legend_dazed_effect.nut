this.legend_dazed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
		// , IsForced = false
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDazed);
		this.m.Icon = "ui/perks/daze56_circle.png";
		this.m.IconMini = "mini_daze56_circle";
		this.m.Overlay = "daze56_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has received so heavy a blow that they are dazed, confused and gasping for air. Will wear off in [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
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
				icon = "ui/icons/regular_damage.png",
				text = "[color=%negative%]-50%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-50%[/color] Max Fatigue"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-50%[/color] Initiative"
			}
		];
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		// if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun || this.m.IsForced)
		// {
		// 	this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		// }
		// else
		// {
		//  this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.Container.getActor().getName()) + " became baffled instead of dazed, due to being stun immune.");
		// 	local forceBaffle = this.new("scripts/skills/effects/legend_baffled_effect");
		// 	forceBaffle.m.IsForced = true;
		// 	this.m.Container.add(forceBaffle);
		//  this.m.IsGarbage = true;
		// }
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
		_properties.DamageTotalMult *= 0.5;
		_properties.InitiativeMult *= 0.5;
		_properties.StaminaMult *= 0.5;

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned))
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
