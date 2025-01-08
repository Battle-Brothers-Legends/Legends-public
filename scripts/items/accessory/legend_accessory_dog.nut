this.legend_accessory_dog <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Skill = null,
		Entity = null,
		Script = "",
		ArmorScript = null,
		UnleashSounds = [
			"sounds/combat/unleash_wardog_01.wav",
			"sounds/combat/unleash_wardog_02.wav",
			"sounds/combat/unleash_wardog_03.wav",
			"sounds/combat/unleash_wardog_04.wav"
		]
	},
	function create()
	{
		this.accessory.create();
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.ItemType = this.Const.Items.ItemType.Accessory;
		this.m.IsUsable = false;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = true;
	}

	function isAllowedInBag()
	{
		//Wierd work around - since player stash queries this in order to enabled drag/drop onto
		//paperdoll - but there is no actor or container yet so we have to allow
		//all wardogs to be allowed in bag , and then when the addToBag check calls
		//this function again, we can check actor and set it to false if not perk
		//is present
		if (::MSU.isNull(m.AddToBagActor) && ::MSU.isNull(getContainer()))
			return true;

		return !::MSU.isNull(m.AddToBagActor) && m.AddToBagActor.getSkills().hasPerk(::Const.Perks.PerkDefs.LegendPackleader);
	}

	function isChangeableInBattle()
	{
		//Wierd work around - since player stash queries this in order to enabled drag/drop onto
		//paperdoll - but there is no actor or container yet so we have to allow
		//all wardogs to be allowed in bag , and then when the addToBag check calls
		//this function again, we can check actor and set it to false if not perk
		//is present

		if (::MSU.isNull(m.IsChangeableInBattleActor) && ::MSU.isNull(getContainer()))
			return true;

		return !::MSU.isNull(m.IsChangeableInBattleActor) && m.IsChangeableInBattleActor.getSkills().hasPerk(::Const.Perks.PerkDefs.LegendPackleader);
	}

	function isUnleashed()
	{
		return this.m.Entity != null;
	}

	function getScript()
	{
		return this.m.Script;
	}

	function getArmorScript()
	{
		return this.m.ArmorScript;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/inventory/wardog_inventory_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
	}

	function updateVariant()
	{
		this.setEntity(this.m.Entity);
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function onPutIntoBag()
	{
	}

	function onCombatFinished()
	{
		this.setEntity(null);
	}

	function onActorDied( _onTile )
	{
		if (_onTile == null)
		{
			return;
		}

		if (!this.isUnleashed())
		{
			if (!_onTile.IsEmpty)
			{
				for( local i = 0; i < 6; i++ )
				{
					if (!_onTile.hasNextTile(i))
					{
					}
					else
					{
						local t = _onTile.getNextTile(i);

						if (t.IsEmpty)
						{
							_onTile = t;
							break;
						}
					}
				}

				if (!_onTile.IsEmpty)
				{
					return;
				}
			}

			local entity = this.Tactical.spawnEntity(this.getScript(), _onTile.Coords.X, _onTile.Coords.Y);
			entity.setItem(this);
			entity.setName(this.getName());
			entity.setVariant(this.getVariant());

			if (this.getContainer().getActor().getSkills().hasPerk(::Const.Perks.PerkDefs.LegendDogWhisperer))
			{
				::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.FortifiedMind);
				::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.Colossus);
				::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.Underdog);
			}

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

	function onEquip()
	{
		this.accessory.onEquip();
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

