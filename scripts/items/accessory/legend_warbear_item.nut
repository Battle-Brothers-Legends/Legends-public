this.legend_warbear_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Skill = null,
		Entity = null,
		Script = "scripts/entity/tactical/legend_warbear",
		UnleashSounds = [
			"sounds/enemies/bear_idle1.wav",
			"sounds/enemies/bear_idle2.wav"
		]
	},
	function getScript()
	{
		return this.m.Script;
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
			return "Bear Collar";
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
			return "The collar of a bear that has been unleashed onto the battlefield.";
		}
	}

	function create()
	{
		this.accessory.create();
		this.m.Variant = this.Math.rand(1, 4);
		this.updateVariant();
		this.m.ID = "accessory.legend_warbear";
		this.m.Name = this.Const.Strings.WarbearNames[this.Math.rand(0, this.Const.Strings.WarbearNames.len() - 1)] + " the Bear";
		this.m.Description = "A strong and wild bear, not fully tamed, but powerful in battle. Can be unleashed to devastating effect, perhaps not near your allies.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Value = 2000;
	}

	function playInventorySound( _eventType )
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.Sound.play("sounds/enemies/bear_idle1.wav", this.Const.Sound.Volume.Inventory);
		}
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
			this.m.Icon = "tools/dog_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/warbear_01_70x70.png";
		}
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashWarbear, function (_skill) {
			_skill.setItem(this);
			this.m.Skill = this.WeakTableRef(_skill);
		}.bindenv(this));
	}

	function onCombatFinished()
	{
		this.setEntity(null);
	}

	function onActorDied( _onTile )
	{
		if (!this.isUnleashed() && _onTile != null)
		{
			local entity = this.Tactical.spawnEntity(this.getScript(), _onTile.Coords.X, _onTile.Coords.Y);
			entity.setItem(this);
			entity.setName(this.getName());
			this.setEntity(entity);
			entity.setFaction(this.Const.Faction.PlayerAnimals);
			this.Sound.play(this.m.UnleashSounds[this.Math.rand(0, this.m.UnleashSounds.len() - 1)], this.Const.Sound.Volume.Skill, _onTile.Pos);
		}
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

