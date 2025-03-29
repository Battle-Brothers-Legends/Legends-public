this.legend_arena_collar_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		affectedSkills = ["legend_leap_skill", "legend_climb_skill", "legend_levitating_skill"]
	},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_arena_collar";
		this.m.Name = "Legend Arena Collar";
		this.m.Description = "A collar worn by combatants for the Legendary tournament location.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/gladiator_necklace.png";
		this.m.Sprite = "gladiator_necklace_01";
		this.m.Value = 0;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
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

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Disables specific skills than can be used to scale the arena walls when worn."
		});
		return result;
	}

	function onEquip()
	{
		local skills = this.getContainer().getActor().getSkills();
		foreach (skill in this.m.affectedSkills)
		{	
			if (skills.hasSkill("actives." + skill))
			{
				skills.removeByID("actives." + skill);
			}
		}
	}

	function onUnequip()
	{
		local skills = this.getContainer().getActor().getSkills();
		foreach (skill in this.m.affectedSkills)
		{	
			if (skills.hasSkill("perk." + skill))
			{
				skills.add(this.new("scripts/skills/actives/" + skill));
			}
		}
	}

	function getBuyPrice()
	{
		return 1000000;
	}

});

