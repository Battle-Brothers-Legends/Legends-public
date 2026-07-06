::Legends.Items <- {};
::Legends.Items.Named <- {};
::Legends.Items.Named.randomizeRanges <- {
    Condition               = [110, 140],
    RegularDamage           = [110, 130],
    ArmorDamageMult         = [10, 30],
    ChanceToHitHead         = [10, 20],
    DirectDamageAdd         = [8, 16],
    StaminaModifier         = [50, 80],
    ShieldDamage            = [150, 200],
    AmmoMax                 = [1, 3],
    AdditionalAccuracy      = [5, 15],
    FatigueOnSkillUse       = [1, 3],
    MeleeDefense            = [130, 150],
    RangedDefense           = [130, 150],
    ConditionShield         = [150, 200],
    StaminaModifierShield   = [60, 90],
	Choke					= [110, 130],
	ArmorDamageMultGloves   = [5, 15],
	DirectDamageMultGloves	= [5, 15],
	StaminaModifierGloves	= [40, 80]
};

::Legends.Items.Named.HighlightNamedRoll <- {
	ConditionMax = {
		Icon = "ui/icons/asset_supplies_named.png",
		Text = "",
        function isRightTooltip(_tooltip, _properties, _item = "weapon") {
			local range = _item == "weapon" ? ::Legends.Items.Named.randomizeRanges.Condition : ::Legends.Items.Named.randomizeRanges.ConditionShield;
			local bVal = _properties.ConditionMax;
			this.Text = " [color=%positiveLighter%]["+::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01)+"][/color]";
			return _tooltip.id == 4	&& _tooltip.type == "progressbar" && _tooltip.icon == "ui/icons/asset_supplies.png";
		}
	},

	RegularDamage = {
		function isRightTooltip(_tooltip, _properties, _item = null) {
			return null;
		}
	},

	RegularDamageMax = {
		Icon = "ui/icons/regular_damage_named.png",
        Text = "",
		function isRightTooltip(_tooltip, _properties, _item = null) {
			local range = ::Legends.Items.Named.randomizeRanges.RegularDamage;
			local bMin = _properties.RegularDamage;
			local bMax = _properties.RegularDamageMax;
			this.Text = ::Legends.Items.Named.wrapTooltip(::Math.round(bMin * range[0] * 0.01) + "-" + ::Math.round(bMin * range[1] * 0.01) + " to " + ::Math.round(bMax * range[0] * 0.01) + "-" + ::Math.round(bMax * range[1] * 0.01));
			return _tooltip.id == 4 && _tooltip.icon == "ui/icons/regular_damage.png";
		}
	},

	ChokeMin = {
		Icon = "ui/icons/regular_damage_named.png",
        Text = "",
		function isRightTooltip(_tooltip, _properties, _item = null) {
			return null;
		}
	},

	ChokeMax = {
		Icon = "ui/icons/regular_damage_named.png",
        Text = "",
		function isRightTooltip(_tooltip, _properties, _item = null) {
			local range = ::Legends.Items.Named.randomizeRanges.Choke;
			local bMin = _properties.ChokeMin;
			local bMax = _properties.ChokeMax;
			this.Text = ::Legends.Items.Named.wrapTooltip(::Math.round(bMin * range[0] * 0.01) + "-" + ::Math.round(bMin * range[1] * 0.01) + " to " + ::Math.round(bMax * range[0] * 0.01) + "-" + ::Math.round(bMax * range[1] * 0.01));
			return _tooltip.id == 5 && _tooltip.icon == "ui/icons/regular_damage.png";
		}
	},

	DirectDamageMult = {
		Icon = "ui/icons/direct_damage_named.png",
        Text = "",
		function isRightTooltip(_tooltip, _properties, _item = null) {
			if(_item == "gloves"){
				local range = ::Legends.Items.Named.randomizeRanges.DirectDamageMultGloves;
				local bVal = 10 + _properties.DirectDamageMult * 100;
				this.Text = ::Legends.Items.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
				return _tooltip.id == 64 && _tooltip.icon == "ui/icons/direct_damage.png";
			}
			else{
				return null;
			}
		}
	},

	DirectDamageAdd = {
		Icon = "ui/icons/direct_damage_named.png",
        Text = "",
		function isRightTooltip(_tooltip, _properties, _item = null) {
			local range = ::Legends.Items.Named.randomizeRanges.DirectDamageAdd;
			local bVal = _properties.DirectDamageMult * 100;
			this.Text = ::Legends.Items.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 64 && _tooltip.icon == "ui/icons/direct_damage.png";
		}
	},

	ArmorDamageMult = {
		Icon = "ui/icons/armor_damage_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = "weapon") {
            local range = _item == "weapon" ? ::Legends.Items.Named.randomizeRanges.ArmorDamageMult : ::Legends.Items.Named.randomizeRanges.ArmorDamageMultGloves;
			local bVal =  _properties.ArmorDamageMult * 100 + (_item == "gloves" ? 50 : 0);
			this.Text = ::Legends.Items.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 5 && _tooltip.icon == "ui/icons/armor_damage.png";
		}
	},

	ShieldDamage = {
		Icon = "ui/icons/shield_damage_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = null) {
            local range = ::Legends.Items.Named.randomizeRanges.ShieldDamage;
			local bVal = _properties.ShieldDamage;
			this.Text = ::Legends.Items.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.id == 6 && _tooltip.icon == "ui/icons/shield_damage.png";
		}
	},

	ChanceToHitHead = {
		Icon = "ui/icons/chance_to_hit_head_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = null) {
            local range = ::Legends.Items.Named.randomizeRanges.ChanceToHitHead;
			local bVal = _properties.ChanceToHitHead;
			this.Text = ::Legends.Items.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 9 && _tooltip.icon == "ui/icons/chance_to_hit_head.png";
		}
	},

	AdditionalAccuracy = {
		Icon = "ui/icons/hitchance_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = null) {
            local range = ::Legends.Items.Named.randomizeRanges.AdditionalAccuracy;
			local bVal = _properties.AdditionalAccuracy;
			this.Text = ::Legends.Items.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 10 && _tooltip.icon == "ui/icons/hitchance.png";
		}
	},

	StaminaModifier = {
		Icon = "ui/icons/fatigue_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = "weapon") {
            local range = _item = "weapon" ? ::Legends.Items.Named.randomizeRanges.StaminaModifier : _item == "shield" ? ::Legends.Items.Named.randomizeRanges.StaminaModifierShield : ::Legends.Items.Named.randomizeRanges.StaminaModifierGloves;
			local bVal = _properties.StaminaModifier;
			this.Text = ::Legends.Items.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.icon == "ui/icons/fatigue.png";
		}
	},

	FatigueOnSkillUse = {
		Icon = "ui/icons/fatigue_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = null) {
            local range = ::Legends.Items.Named.randomizeRanges.FatigueOnSkillUse;
			local bVal = _properties.FatigueOnSkillUse;
			this.Text = ::Legends.Items.Named.wrapTooltip((bVal - range[0]) + " to " + (bVal - range[1]));
			return _tooltip.id == 8	&& _tooltip.icon == "ui/icons/fatigue.png" && _tooltip.text.find("skills build up") != null;
		}
	},

	AmmoMax = {
		Icon = "ui/icons/ammo_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = null) {
            local range = ::Legends.Items.Named.randomizeRanges.AmmoMax;
			local bVal = _properties.AmmoMax;
			this.Text = ::Legends.Items.Named.wrapTooltip((bVal + range[0]) + " - " + (bVal + range[1]));
			return _tooltip.id == 10 && _tooltip.icon == "ui/icons/ammo.png";
		}
	},

	MeleeDefense = {
		Icon = "ui/icons/melee_defense_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = null) {
            local range = ::Legends.Items.Named.randomizeRanges.MeleeDefense;
            local bVal = _properties.MeleeDefense;
            this.Text = ::Legends.Items.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.id == 5 && _tooltip.icon == "ui/icons/melee_defense.png";
		}
	},

	RangedDefense = {
		Icon = "ui/icons/ranged_defense_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _item = null) {
            local range = ::Legends.Items.Named.randomizeRanges.RangedDefense;
            local bVal = _properties.RangedDefense;
            this.Text = ::Legends.Items.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.id == 6 && _tooltip.icon == "ui/icons/ranged_defense.png";
		}
	},
};


::Legends.Items.Named.wrapTooltip <- function (_tooltip) {
	return "\n[color=%positive%][" + _tooltip + "][/color]";
}

::Legends.Items.Named.getRangeOfSpecialEffect <- function (_item, _includePercent = true){
    return ::Legends.Mod.ModSettings.getSetting("ShowPotentialOnItems").getValue() ? ::Legends.Items.Named.wrapTooltip(_item.m.EffectBounds[_item.m.PossibleEffectIdx][0] + (_includePercent ? "%" : "") + " to " + _item.m.EffectBounds[_item.m.PossibleEffectIdx][1]) : (_includePercent ? "%" : "");
}

::Legends.Items.Named.ShowArmorPotential <- function (_item, _result) {
	if (!::Legends.Mod.ModSettings.getSetting("ShowPotentialOnItems").getValue()) {
		return;
	}

	foreach (tooltip in _result) {
		if (!tooltip.rawin("id") || !tooltip.rawin("text") || !tooltip.rawin("icon")) {
			continue;
		}

		if (tooltip.id == 4 && (tooltip.icon == "ui/icons/armor_body.png" || tooltip.icon == "ui/icons/armor_head.png")) {
			tooltip.text += " [" + _item.m.Potential.Condition.min + " to " + _item.m.Potential.Condition.max + "]";

		} else if (tooltip.id == 5 && tooltip.icon == "ui/icons/fatigue.png" && tooltip.text.find("Fatigue Weight Penalty:") != null) {
			tooltip.text += ::Legends.Items.Named.wrapTooltip(_item.m.Potential.StaminaModifier.min * -1 + " to " + _item.m.Potential.StaminaModifier.max * -1);
		}
		else if (tooltip.id == 6 && tooltip.icon == "ui/icons/vision.png") { //&& "Vision" in _item.m.Potential
			tooltip.text += ::Legends.Items.Named.wrapTooltip(_item.m.Potential.Vision.min * -1 + " to " + _item.m.Potential.Vision.max * -1);
		}
		else if (tooltip.id == 15 && tooltip.icon == "ui/icons/direct_damage.png") { //&& "DirectDamageModifier" in _item.m.Potential
			tooltip.text += ::Legends.Items.Named.wrapTooltip(_item.m.Potential.DirectDamageModifier.max * -1 + "% to " + _item.m.Potential.DirectDamageModifier.min * -1 + "%");
		}
		else if (tooltip.id == 15 && tooltip.icon == "ui/icons/special.png" && tooltip.text.find("Resolve") != null && "BraveryMult" in _item.m.Potential) {
			tooltip.text += ::Legends.Items.Named.wrapTooltip((_item.m.Potential.BraveryMult.min - 100) + "% to " + (_item.m.Potential.BraveryMult.max - 100) + "%");
		}
	}
}