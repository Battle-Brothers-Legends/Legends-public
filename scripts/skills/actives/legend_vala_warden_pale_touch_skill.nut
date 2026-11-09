this.legend_vala_warden_pale_touch_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendValaWardenPaleTouch);
		this.m.Description = "";
		this.m.KilledString = "Frightened to death";
		this.m.SoundOnUse = ["sounds/combat/legend_vala_warden_pale_touch.wav"];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onUse(_user, _targetTile) {
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill == this) {
			local warden = this.getContainer().getActor();
			local vala = warden.getVala().get();
			local spiritualBond = ::Legends.Perks.has(vala, ::Legend.Perk.LegendValaSpiritualBond) ? vala.getBravery() * ::Legends.Perks.get(vala, ::Legend.Perk.LegendValaSpiritualBond).getDamageScaling() : 0;
			local fury = ::Legends.Effects.has(vala, ::Legend.Effect.LegendValaChantFury) ? ::Legends.Effects.get(this, ::Legends.Effect.LegendValaChantFury).getWardenDamage() : 0;

			_properties.DamageRegularMin += 10 + ::Math.round(spiritualBond * 0.67) + ::Math.round(fury * 0.67);
			_properties.DamageRegularMax += 15 + ::Math.round(spiritualBond) + ::Math.round(fury);
			_properties.IsIgnoringArmorOnAttack = true;
		}
	}
});
