this.legend_sighthound_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSighthoundBite);
		this.m.Description = "";
		this.m.KilledString = "Mangled";
		this.m.Icon = "skills/dawg_bite.png";
		this.m.IconDisabled = "skills/dawg_bite_sw.png";
		this.m.Overlay = "dawg_bite";
		this.m.SoundOnUse = [
			"sounds/enemies/wardog_bite_00.wav",
			"sounds/enemies/wardog_bite_01.wav",
			"sounds/enemies/wardog_bite_02.wav",
			"sounds/enemies/wardog_bite_03.wav",
			"sounds/enemies/wardog_bite_04.wav",
			"sounds/enemies/wardog_bite_05.wav",
			"sounds/enemies/wardog_bite_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingActorPitch = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onUpdate(_properties) {
		_properties.DamageRegularMin += 30;
		_properties.DamageRegularMax += 45;
		_properties.DamageArmorMult *= 0.4;
	}

	function onUse(_user, _targetTile) {
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});
