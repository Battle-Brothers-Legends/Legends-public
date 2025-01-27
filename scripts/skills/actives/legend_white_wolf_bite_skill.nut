this.legend_white_wolf_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_white_wolf_bite";
		this.m.Name = "White Direwolf Bite";
		this.m.Description = "";
		this.m.KilledString = "Ripped to shreds";
		this.m.Icon = "skills/active_71.png";
		this.m.Overlay = "active_71";
		this.m.SoundOnUse = [
			"sounds/enemies/wolf_bite_01.wav",
			"sounds/enemies/wolf_bite_02.wav",
			"sounds/enemies/wolf_bite_03.wav",
			"sounds/enemies/wolf_bite_04.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/enemies/werewolf_claw_hit_01.wav",
			"sounds/enemies/werewolf_claw_hit_02.wav",
			"sounds/enemies/werewolf_claw_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 45;
		_properties.DamageRegularMax += 75;
		_properties.DamageArmorMult *= 0.8;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

