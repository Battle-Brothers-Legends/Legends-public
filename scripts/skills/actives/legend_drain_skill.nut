this.legend_drain_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrain);
		this.m.Description = "Pull the essence from your foe, and draw it into yourself.";
		this.m.KilledString = "Drained";
		this.m.Icon = "skills/blooddrop_square.png";
		this.m.IconDisabled = "skills/blooddrop_square_bw.png";
		this.m.Overlay = "blooddrop_square";
		this.m.SoundOnUse = [
			"sounds/combat/drain_01.wav",
			"sounds/combat/drain_02.wav",
			"sounds/combat/drain_03.wav",
			"sounds/combat/drain_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Item +10;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local CurrentInit = actor.getInitiative();
		local maxHP = actor.getHitpointsMax();
		local heal = maxHP / 10;
		local MinDam =  CurrentInit - 100;
		local MaxDam =  CurrentInit - 90;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/health.png", // fix from /ui to ui/ Abyss 6/17/23
				text = "Inflicts initiative -100 as damage. Does [color=%damage%]" + MinDam + "[/color] - [color=%damage%]" + MaxDam + "[/color] damage. Heals for" + heal + " as 10% of your max health"
			}
		];
	}

	function onUpdate( _properties )
	{

		local CurrentInit = this.getContainer().getActor().getInitiative();
		_properties.DamageRegularMin += this.Math.floor(CurrentInit - 100);
		_properties.DamageRegularMax += this.Math.floor(CurrentInit - 90);
	}

	function onUse( _user, _targetTile )
	{
		local res = this.attackEntity(_user, _targetTile.getEntity());
		if (res)
		{
			local actor = this.getContainer().getActor();
			local maxHP = actor.getHitpointsMax();
			local heal = maxHP / 10;
			actor.setHitpoints(this.Math.min(actor.getHitpoints() + heal, maxHP));
		}
		return res
	}

});
