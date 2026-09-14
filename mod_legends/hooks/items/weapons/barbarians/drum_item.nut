::mods_hookExactClass("items/weapons/barbarians/drum_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Name = "Barbarian Drum";
		this.m.Description = "A barbarian instrument, can produce inspiring rhythms if you have the skill. The drum sticks make weak maces in a pinch.";
		this.m.Categories = "Musical Instrument, Two-Handed";
		this.m.IconLarge = "weapons/melee/wildmen_10.png";
		this.m.Icon = "weapons/melee/wildmen_10_70x70.png";
		this.m.BreakingSound = "sounds/combat/bash_hit_03.wav";
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.IsDoubleGrippable = false;
		this.m.IsDroppedAsLoot = true;
		this.m.RangeMax = 1;
		this.m.RangeIdeal = 1;
		this.m.Value = 300;
		this.m.Condition = 45;
		this.m.ConditionMax = 45;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.4;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.IsDrumBash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut);
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrumsOfWar);
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrumsOfLife);
		::Legends.Actives.grant(this, ::Legends.Active.LegendMartialMarch);
		::Legends.Actives.remove(this, ::Legends.Active.DrumsOfWar);
	}

	o.onUpdateProperties <- function ( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}
});
