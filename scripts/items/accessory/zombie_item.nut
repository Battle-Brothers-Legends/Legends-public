this.zombie_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Skill = null,
		Entity = null,
		Script = "scripts/entity/tactical/legends_zombie",
		ArmorScript = null,
		UnleashSounds = [
			"sounds/enemies/geist_idle_10.wav",
			"sounds/enemies/geist_idle_11.wav",
			"sounds/enemies/geist_idle_12.wav"
		]
	},
	function isAllowedInBag()
	{
		return false;
	}

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
			return "Wardog Collar";
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
			return "The collar of a wardog that has been unleashed onto the battlefield.";
		}
	}

	function create()
	{
		this.accessory.create();
		this.m.Variant = 1
		this.updateVariant();
		this.m.ID = "accessory.zombie";
		this.m.Name = this.Const.Strings.WardogNames[this.Math.rand(0, this.Const.Strings.WardogNames.len() - 1)] + " the Zombie";
		this.m.Description = "An undead minion. Can be unleashed to do your bidding";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		local index = this.Math.rand(1, 16)
		local variant = "" + index;
		if (index < 10){
			variant = "0" + index;
		}
		this.Sound.play("sounds/enemies/zombie_idle_" +  variant + ".wav", this.Const.Sound.Volume.Inventory);
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
			this.m.Icon = "tools/zombie_01_0" + this.m.Variant + "_70x70.png";
		}
	}

	function onEquip()
	{
		this.accessory.onEquip();
		local unleash = this.new("scripts/skills/actives/unleash_zombie");
		unleash.setItem(this);
		this.m.Skill = this.WeakTableRef(unleash);
		this.addSkill(unleash);
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
			entity.setVariant(this.getVariant());
			this.setEntity(entity);
			entity.setFaction(this.Const.Faction.PlayerAnimals);

			if (this.m.ArmorScript != null)
			{
				local item = this.new(this.m.ArmorScript);
				entity.getItems().equip(item);
			}

			this.Sound.play(this.m.UnleashSounds[this.Math.rand(0, this.m.UnleashSounds.len() - 1)], this.Const.Sound.Volume.Skill, _onTile.Pos);
		}
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
