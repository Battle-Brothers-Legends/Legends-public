this.legend_wind_up_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendWindUp);
		this.m.Description = "Evaluate your enemy, preparing your next attack to push them back.";
		this.m.Icon = "skills/active_10.png";
		this.m.IconDisabled = "skills/active_10_sw.png";
		this.m.Overlay = "mini_smackdown_circle";
		this.m.SoundOnUse = [
			"sounds/combat/rupture_blood_01.wav",
			"sounds/combat/rupture_blood_02.wav",
			"sounds/combat/rupture_blood_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 15;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.IsHidden = false;
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
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		local canUse = ::Legends.Effects.get(this, ::Legends.Effect.LegendKnockbackPrepared);

		if (canUse != null)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "This character is already wound up."
			});
			return ret;
		}

		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local hasMelee = item == null || item.isItemType(this.Const.Items.ItemType.MeleeWeapon);

		if (hasMelee)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next attack will push the enemy back and baffle them if it connects, otherwise the effect is wasted."
			});
		}
		else if (item.isWeaponType(this.Const.Items.WeaponType.Sling) && item.isItemType(this.Const.Items.ItemType.OneHanded))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next attack will deal increased damage and armor penetration based on your current initiative."
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Requires a melee weapon, an unarmed attack or a one handed sling"
			});
		}

		return ret;
	}

	function isHidden()
	{
		local canUse = ::Legends.Effects.get(this, ::Legends.Effect.LegendKnockbackPrepared);
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local hasMelee = item == null || item.isItemType(this.Const.Items.ItemType.MeleeWeapon) || (item.isWeaponType(this.Const.Items.WeaponType.Sling) && item.isItemType(this.Const.Items.ItemType.OneHanded));
		return !((!this.Tactical.isActive() || canUse == null) && hasMelee);
	}

	function onUse( _user, _targetTile )
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Sling) && item.isItemType(this.Const.Items.ItemType.OneHanded))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendPrepareBullet);
		}
		else
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendKnockbackPrepared);
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
			return;

		if (item.isItemType(this.Const.Items.ItemType.TwoHanded))
			this.m.ActionPointCost = 1;
		else if (item.isItemType(this.Const.Items.ItemType.OneHanded))
			this.m.ActionPointCost = 2;
	}
});
