this.legend_launch_daze_bomb_skill <- this.inherit("scripts/skills/actives/throw_daze_bomb_skill", {
	m = {
		Item = null
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendLaunchDazeBomb);
		this.m.Description = "Launch a pot, with your slingstaff, filled with mysterious powders that react violently on impact to create a bright flash and loud bang, and will daze anyone close by - friend and foe alike";
		this.m.SoundOnUse = [
			"sounds/combat/dlc4/sling_use_01.wav",
			"sounds/combat/dlc4/sling_use_02.wav",
			"sounds/combat/dlc4/sling_use_03.wav",
			"sounds/combat/dlc4/sling_use_04.wav"
		];
		this.m.Delay = 750;
		this.m.IsRanged = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 4;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 7;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Give up to [color=" + this.Const.UI.Color.DamageValue + "]7[/color] targets the Dazed status effect for 2 turns"
		});

		local ammo = 0;
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.daze_bomb")
			{
				if (item.getAmmo() != 0)
				{
					ammo += item.getAmmo();
				}
			}
		}

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] use left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]No ammo left in backpack[/color]"
			});
		}

		return ret;
	}

	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function isHidden()
	{
		if (!this.getContainer().hasPerk(::Legends.Perk.LegendSlingerSpins))
			return true;
		if (this.m.Item != null && !this.m.Item.isNull())
			if (this.m.Item.getAmmo() != 0)
				return false;

		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.daze_bomb")
			{
				if (item.getAmmo() != 0)
				{
					this.setItem(item);
					return false;
				}
			}
		}
		this.m.Item = null;
		return true;
	}

	function getAmmo()
	{
		if (this.m.Item != null && !this.m.Item.isNull())
			return this.m.Item.getAmmo();

		return 0;
	}

	function consumeAmmo()
	{
		if (this.m.Item != null && !this.m.Item.isNull())
			this.m.Item.consumeAmmo();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = 0;
			_properties.DamageRegularMax = 0;
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.MaxRange + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
