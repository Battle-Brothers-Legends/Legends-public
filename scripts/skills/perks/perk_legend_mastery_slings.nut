this.perk_legend_mastery_slings <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendMasterySlings);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInSlings = true;
	}

	function onWaitTurn()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		if (item != null && _item.isWeaponType(this.Const.Items.WeaponType.Sling) && _item.isItemType(this.Const.Items.ItemType.OneHanded))
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendPrepareBullet);
	}

});
