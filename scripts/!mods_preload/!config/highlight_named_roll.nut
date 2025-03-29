::Const.HighlightNamedRoll <- 
{
	ConditionMax = 
	{
		Icon = "ui/icons/asset_supplies_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 4 && _tooltip.type == "progressbar" && _tooltip.icon == "ui/icons/asset_supplies.png";
		}
	},

	RegularDamageMax =
	{
		Icon = "ui/icons/regular_damage_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 4 && _tooltip.icon == "ui/icons/regular_damage.png";
		}
	},

	DirectDamageAdd =
	{
		Icon = "ui/icons/direct_damage_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 64 && _tooltip.icon == "ui/icons/direct_damage.png";
		}
	},

	ArmorDamageMult =
	{
		Icon = "ui/icons/armor_damage_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 5 && _tooltip.icon == "ui/icons/armor_damage.png";
		}
	},

	ShieldDamage =
	{
		Icon = "ui/icons/shield_damage_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 6 && _tooltip.icon == "ui/icons/shield_damage.png";
		}
	},

	ChanceToHitHead =
	{
		Icon = "ui/icons/chance_to_hit_head_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 9 && _tooltip.icon == "ui/icons/chance_to_hit_head.png";
		}
	},

	AdditionalAccuracy =
	{
		Icon = "ui/icons/hitchance_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 10 && _tooltip.icon == "ui/icons/hitchance.png";
		}
	},
	
	StaminaModifier =
	{
		Icon = "ui/icons/fatigue_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.icon == "ui/icons/fatigue.png";
		}
	},

	FatigueOnSkillUse =
	{
		Icon = "ui/icons/fatigue_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 8 && _tooltip.icon == "ui/icons/fatigue.png" && _tooltip.text.find("skills build up") != null;
		}
	},

	AmmoMax =
	{
		Icon = "ui/icons/ammo_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 10 && _tooltip.icon == "ui/icons/ammo.png";
		}
	},

	MeleeDefense =
	{
		Icon = "ui/icons/melee_defense_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 5 && _tooltip.icon == "ui/icons/melee_defense.png";
		}
	},

	RangedDefense =
	{
		Icon = "ui/icons/ranged_defense_named.png",
		function isRightTooltip( _tooltip )
		{
			return _tooltip.id == 6 && _tooltip.icon == "ui/icons/ranged_defense.png";
		}
	},
};