this.legend_white_wolf_item <- this.inherit("scripts/items/accessory/legend_accessory_dog", {
	m = {},

	function create()
	{
		this.legend_accessory_dog.create();
		this.m.Script = "scripts/entity/tactical/legend_white_warwolf";
		this.m.UnleashSounds = [
			"sounds/enemies/wolf_idle_00.wav",
			"sounds/enemies/wolf_idle_01.wav",
			"sounds/enemies/wolf_idle_02.wav",
			"sounds/enemies/wolf_idle_03.wav",
			"sounds/enemies/wolf_idle_04.wav",
			"sounds/enemies/wolf_idle_06.wav",
			"sounds/enemies/wolf_idle_07.wav",
			"sounds/enemies/wolf_idle_08.wav",
			"sounds/enemies/wolf_idle_09.wav"
		];
		this.m.Variant = this.Math.rand(1, 4);
		this.updateVariant();
		this.m.ID = "accessory.legend_white_warwolf";
		this.m.Name = this.Const.Strings.WardogNames[this.Math.rand(0, this.Const.Strings.WardogNames.len() - 1)] + " the White Wolf";
		this.m.Description = "A legendary white wolf, tamed to be a loyal companion in battle. Can be unleashed in battle.";
		this.m.Value = 6000;
	}

	function getName()
	{
		if (this.m.Entity == null)
		{
			return this.item.getName();
		}
		else
		{
			return "Wolf Collar";
		}
	}

	function getDescription()
	{
		if (this.m.Entity == null)
		{
			return this.item.getDescription();
		}
		else
		{
			return "The collar of a white wolf that has been unleashed onto the battlefield.";
		}
	}

	function playInventorySound( _eventType )
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.Sound.play("sounds/enemies/wolf_idle_08.wav", this.Const.Sound.Volume.Inventory);
		}
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/legend_white_wolf_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/legend_white_wolf_01_70x70.png";
		}
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashWhiteWolf, function (_skill) {
			_skill.setItem(this);
			this.m.Skill = this.WeakTableRef(_skill);
		}.bindenv(this));
	}

});

