this.legend_sighthound_item <- this.inherit("scripts/items/accessory/legend_accessory_dog", {
	m = {},

	function create() {
		this.legend_accessory_dog.create();
		this.m.Script = "scripts/entity/tactical/legend_sighthound";
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "accessory.legend_sighthound";
		this.m.Name = this.Const.Strings.WardogNames[this.Math.rand(0, this.Const.Strings.WardogNames.len() - 1)] + " the Sighthound";
		this.m.Description = "A strong and loyal southern sighthound bred for war. Can be unleashed in battle for scouting, tracking or running down routing enemies.";
		this.m.Value = 200;
	}

	function getDescription() {
		if (this.m.Entity == null) {
			return this.item.getDescription();
		} else {
			return "The collar of a sighthound that has been unleashed onto the battlefield.";
		}
	}

	function getName() {
		if (this.m.Entity == null) {
			return this.item.getName();
		} else {
			return "Sighthound Collar";
		}
	}

	function onEquip() {
		this.legend_accessory_dog.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashSighthound, function (_skill) {
			_skill.setItem(this);
			_skill.m.Name = "Unleash Sighthound";
			_skill.m.Description = "Unleash your sighthound and send him charging into the enemy. Needs a free tile adjacent.";
			_skill.m.Icon = "skills/unleash_dawg.png";
			_skill.m.IconDisabled = "skills/unleash_dawg_sw.png";
			_skill.m.Overlay = "unleash_dawg";
			this.m.Skill = this.WeakTableRef(_skill);
		}.bindenv(this));
	}

	function setEntity(_e) {
		this.m.Entity = _e;
		if (this.m.Entity != null) {
			this.m.Icon = "tools/dog_01_leash_70x70.png";
		} else {
			this.m.Icon = "tools/dawg_01_0" + this.m.Variant + "_70x70.png";
		}
	}

});
