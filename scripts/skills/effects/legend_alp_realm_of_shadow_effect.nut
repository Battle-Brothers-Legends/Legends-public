this.legend_alp_realm_of_shadow_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendAlpRealmOfShadow);
		this.m.Icon = "skills/status_effect_81.png";
		this.m.IconMini = "status_effect_81_mini";
		this.m.Overlay = "status_effect_81";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/dlc2/nightmare", 8);
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = false;
		this.m.IsActive = false;
	}

	function getDescription()
	{
		return "This character is consumed by unnatural black mist and is experiencing supernatural terror. The horrors eat away at their sanity and they will soon be broken.";
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
		];

		if (this.getContainer().getActor().getFlags().has("alp"))
		{
			ret.extend([
				{
					id = 9,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=%positive%]+33%[/color] Resolve"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=%positive%]+10[/color] Melee Defense"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=%positive%]+100%[/color] Ranged Defense"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Not affected by Zones of Control"
				}
			]);
			return ret;
		}

		ret.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-1[/color] Vision"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-33%[/color] Resolve"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-10%[/color] Initiative"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Takes [color=%negative%]33%[/color] more damage from [color=%negative%]Nightmare[/color]"
			}
		]);

		return ret;
	}

	function onNewRound()
	{
		local myTile = this.getContainer().getActor().getTile();

		if (myTile.Properties.Effect == null || myTile.Properties.Effect.Timeout == ::Time.getRound() || myTile.Properties.Effect.Type != "legend_shadow_mist")
			this.removeSelf();
	}

	function onMovementFinished()
	{
		local tile = this.getContainer().getActor().getTile();
		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "legend_shadow_mist")
			this.removeSelf();
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getFlags().has("alp"))
		{
			_properties.IsImmuneToZoneOfControl = true;
			_properties.BraveryMult *= 1.33;
			_properties.RangedDefenseMult *= 2.0;
			_properties.MeleeDefense += 10;
			return;
		}

		_properties.Vision -= 1;
		_properties.BraveryMult *= 0.67;
		_properties.InitiativeMult *= 0.9;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null)
			return;

		if (_skill == null || _skill.getID() != ::Legends.Actives.getID(::Legends.Active.Nightmare))
			return;

		_properties.DamageReceivedTotalMult *= 1.33;
	}

});

