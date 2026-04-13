this.legend_unhold_throwing_net <- this.inherit("scripts/items/weapons/weapon", {
	m = {},

	function create()
	{
		this.weapon.create();
		this.m.ID = "tool.legend_unhold_throwing_net";
		this.m.Name = "Unhold bindings";
		this.m.Description = "A net provided by barbarian tribe, used to bind unholds. Tainted with secret poison, it makes [color=%negative%]dazed[/color], [color=%negative%]baffled[/color] or with less than 25% Healthpoints Unholds docile when trapped.";
		this.m.IconLarge = "tools/inventory_throwing_net_unhold.png";
		this.m.Icon = "tools/throwing_net_unhold_70x70.png";
		this.m.ArmamentIcon = "icon_throwing_net_02";
		this.m.SlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Tool | ::Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_throwing_net_02";
		this.m.Value = 150;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = -2;
		this.m.IsPrecious = true;
		this.m.IsSellable = false;
		this.m.IsDroppedAsLoot = false;
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Range of [color=%positive%]" + this.m.RangeMax + "[/color] tiles"
		});
		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=%negative%]" + this.m.StaminaModifier + "[/color]"
			});
		}
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will root a [color=%negative%]dazed[/color], [color=%negative%]baffled[/color] or with less than 25% Healthpoints Unhold in place and make it docile"
		});
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Is destroyed on use"
		});
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/throw_net");
		skill.makeUnholdNet();
		this.addSkill(skill);
	}
});
