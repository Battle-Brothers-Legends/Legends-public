this.alp_realm_of_shadow <- ::inherit("scripts/skills/skill", {
	m = {
		Counter = 0,
	},
	function create()
	{
		this.m.ID = "effects.alp_realm_of_shadow";
		this.m.Name = "Engulfed By Darkness";
		this.m.Icon = "skills/status_effect_81.png";
		this.m.IconMini = "status_effect_81_mini";
		this.m.Overlay = "status_effect_81";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/nightmare_01.wav",
			"sounds/enemies/dlc2/nightmare_02.wav",
			"sounds/enemies/dlc2/nightmare_03.wav",
			"sounds/enemies/dlc2/nightmare_04.wav",
			"sounds/enemies/dlc2/nightmare_05.wav",
			"sounds/enemies/dlc2/nightmare_06.wav",
			"sounds/enemies/dlc2/nightmare_07.wav",
			"sounds/enemies/dlc2/nightmare_08.wav"
		];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = false;
		this.m.IsActive = false;
	}

	function getDescription()
	{
		return "This character is consumed by the unnatural black mist and is showing signs of fear. As the horrors eat away at his sanity, he would soon be broken.";
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
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+25%[/color] Resolve"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color] Ranged Defense"
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
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-1[/color] Vision"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-33%[/color] Resolve"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-10%[/color] Initiative"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Takes [color=" + ::Const.UI.Color.NegativeValue + "]25%[/color] more damage from [color=" + ::Const.UI.Color.NegativeValue + "]Nightmare[/color]"
			}
		]);

		return ret;
	}

	function onNewRound()
	{
		local myTile = this.getContainer().getActor().getTile();

		if (myTile.Properties.Effect == null || myTile.Properties.Effect.Timeout == ::Time.getRound() || myTile.Properties.Effect.Type != "shadows")
			this.removeSelf();
	}

	function onMovementCompleted( _tile )
	{
		if (_tile.Properties.Effect == null || _tile.Properties.Effect.Type != "shadows")
			this.removeSelf();
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getFlags().has("alp"))
		{
			_properties.IsImmuneToZoneOfControl = true;
			_properties.BraveryMult *= 1.25;
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

		if (_skill == null || _skill.getID != "actives.nightmare")
			return;

		_properties.DamageReceivedTotalMult *= 1.25;
	}

});

