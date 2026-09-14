this.legend_spawn_item <- this.inherit("scripts/items/item", {
	m = {
		StaminaModifier = 0,
		AddGenericSkill = true,
		ShowOnCharacter = false,
		Sprite = null,
		SpriteCorpse = null,
		Entity = null,
		DecayRate = 0.2
	},

	function isAllowedInBag(_actor = null)
	{
		return false;
	}

	function getStaminaModifier()
	{
		return this.m.StaminaModifier;
	}

	function create()
	{
		this.item.create();
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc;
	}

	function getTooltip()
	{
		local desc = this.getDescription() + " Requires [color=%negative%]" + this.getMedicinePerDay() + "[/color] units of medicine per day to maintain.";
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = desc
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 65,
			type = "text",
			text = "Usable in Combat"
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=%negative%]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.Condition < this.m.ConditionMax)
		{
			result.push({
				id = 67,
				type = "text",
				text = "Decayed [color=%negative%]" + (100 - this.m.Condition * 100) + "%[/color] due to lack of medical parts"
			});
		}

		return result;
	}

	function isUnleashed()
	{
		return this.m.Entity != null;
	}

	function getDescription()
	{
		return this.item.getDescription();
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;
	}

	function onUpdateProperties( _properties )
	{
	}

	function getMedicinePerDay()
	{
		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (!bro.getSkills().hasPerk(::Legends.Perk.LegendConservation))
				continue;

			local skill = ::Legends.Perks.get(bro, ::Legends.Perk.LegendConservation);
			return this.Math.floor(this.m.MedicinePerDay * skill.m.MedicinePerDayMult);
		}
		return this.m.MedicinePerDay;
	}

	function onCombatFinished()
	{
		if (this.m.Entity == null)
		{
			return
		}

		if (this.m.Entity.m.IsAlive)
		{
			this.setEntity(null);
			this.World.Assets.getStash().add(this);
			return;
		}

		this.setEntity(null);
	}


	function onNewDay()
	{

		if (!this.World.Assets.isUsingProvisions())
		{
			return;
		}

		if (this.World.Assets.getMedicine() >= this.getMedicinePerDay()) {
			this.World.Assets.addMedicine(-this.getMedicinePerDay());
			if (this.m.Condition < this.m.ConditionMax)
			{
				this.m.Condition = this.Math.min(this.m.ConditionMax, this.m.Condition += this.m.DecayRate);
			}
		} else {
			this.World.Assets.addMedicine(-this.World.Assets.getMedicine());
			this.m.Condition = this.Math.min(0, this.m.Condition -= this.m.DecayRate);
		}

		if (this.m.Condition <= 0)
		{
			this.World.Assets.getStash().remove(this);
		}

	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
	}

});
