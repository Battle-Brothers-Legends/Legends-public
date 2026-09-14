this.legend_cat_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Skill = null,
		Entity = null,
		Script = "scripts/entity/tactical/legend_cat",
		ArmorScript = null,
		UnleashSounds = [
			"sounds/combat/cat_purr_01.wav",
			"sounds/combat/cat_purr_02.wav"

		]
	},
	function getScript()
	{
		return this.m.Script;
	}

	function getArmorScript()
	{
		return this.m.ArmorScript;
	}

	function isUnleashed()
	{
		return this.m.Entity != null;
	}

	function getName()
	{
		if (this.m.Entity == null)
		{
			return this.item.getName();
		}
		else
		{
			return "Cat Collar";
		}
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function getDescription()
	{
		if (this.m.Entity == null)
		{
			return this.item.getDescription();
		}
		else
		{
			return "The collar of a cat that has been summoned onto the battlefield";
		}
	}

	function create()
	{
		this.accessory.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "accessory.legend_cat_item";
		this.m.Name = this.Const.Strings.LegendCatNames[this.Math.rand(0, this.Const.Strings.LegendCatNames.len() - 1)] + " the Cat";
		this.m.Description = "A mysterious cat that seems all too intelligent";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsAllowedInBag = false;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Value = 100;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/enemies/cat_purr_02.wav", this.Const.Sound.Volume.Inventory);
	}

	function updateVariant()
	{
		this.setEntity(this.m.Entity);
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/cat_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/cat_01_01_70x70.png";
		}
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashCat, function (_skill) {
			_skill.setItem(this);
			this.m.Skill = this.WeakTableRef(_skill);
		}.bindenv(this));
	}

	function onCombatFinished()
	{
		this.setEntity(null);
	}

	function onSerialize( _out )
	{
		this.accessory.onSerialize(_out);
		_out.writeString(this.m.Name);
	}

	function onDeserialize( _in )
	{
		this.accessory.onDeserialize(_in);
		this.m.Name = _in.readString();
	}

});
