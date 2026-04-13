this.perk_legend_mastery_slings <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasterySlings);
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInSlings = true;
	}

	function onWaitTurn()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Sling) && item.isItemType(this.Const.Items.ItemType.OneHanded))
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendPrepareBullet);
	}

});
