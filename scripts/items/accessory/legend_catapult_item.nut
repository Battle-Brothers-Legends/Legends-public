this.legend_catapult_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Skill = null,
		Entity = null,
		Script = "scripts/entity/tactical/legend_war_catapult",
		ArmorScript = null,
		UnleashSounds = [
				"sounds/enemies/unhold_idle_01.wav"
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
			return "The leash of a catapult that has been unleashed onto the battlefield.";
		}
	}

	function create()
	{
		this.accessory.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "accessory.legend_catapult";
		this.m.Name = "Catapult";
		this.m.Description = "A war machine, can be constructed in battle to inflict damage from afar.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Value = 10000;
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
			this.m.Icon = "tools/catapult_0" + this.m.Variant + "_70x70.png";
		}
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashCatapult, function (_skill) {
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

