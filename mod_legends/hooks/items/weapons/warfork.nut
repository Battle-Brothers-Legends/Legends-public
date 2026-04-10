::mods_hookExactClass("items/weapons/warfork", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/warfork_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/warfork_01" + v + ".png";
		this.m.ArmamentIcon = "icon_warfork_01" + v;
	}

	o.onEquip = function ()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Prong, function (_skill)
		{
			_skill.m.Icon = "skills/active_174.png";
			_skill.m.IconDisabled = "skills/active_174_sw.png";
			_skill.m.Overlay = "active_174";
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendSkewer, function (_skill)
		{
			_skill.m.Icon = "skills/skewer_warfork.png";
			_skill.m.IconDisabled = "skills/skewer_warfork_bw.png";
			_skill.m.Overlay = "skewer_warfork";
			_skill.m.IsSpearSkewer = true;
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendWarforkDisarm);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Spearwall, function (_skill)
		{
			_skill.m.Icon = "skills/active_173.png";
			_skill.m.IconDisabled = "skills/active_173_sw.png";
			_skill.m.Overlay = "active_173";
			_skill.m.BaseAttackName = "Prong";
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
			_skill.m.ActionPointCost = 6;
		}.bindenv(this));
	}
});
