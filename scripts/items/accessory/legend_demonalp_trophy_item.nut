this.legend_demonalp_trophy_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_demonalp_trophy";
		this.m.Name = "Demon Alp Trophy Necklace";
		this.m.Description = "This necklace fashioned from trophies taken of various demon alps declares the one wearing it a veteran of battle against supernatural nocturnal predators, and not easily daunted.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/demonalp_trophy.png";
		this.m.Sprite = "alp_trophy";
		this.m.Value = 2500;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 66,
				type = "text",
				text = this.getValueString()
			},
			{
				id = 3,
				type = "image",
				image = this.getIconLarge() != null ? this.getIconLarge() : this.getIcon(),
				isLarge = this.getIconLarge() != null
			},
			{
				id = 67,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=%positive%]10%[/color] Experience Gain"
			},
			{
				id = 68,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%positive%]+1[/color] Vision"
			},
			{
				id = 69,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Mitigates [color=%positive%]50%[/color] of night penalties."
			}
		];
	}

	function onUpdateProperties(_properties) {
		this.accessory.onUpdateProperties(_properties);
		_properties.XPGainMult *= 1.1;
		_properties.Vision += 1;
	}

	function onAfterUpdateProperties(_properties) {
		this.accessory.onAfterUpdateProperties(_properties);

		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return;

		if (_properties.IsAffectedByNight && ::Legends.Effects.has(this.getContainer().getActor(), ::Legends.Effect.Night)) {
			_properties.Vision += 1;
			_properties.RangedSkillMult *= 1.214;
			_properties.RangedDefense *= 1.214;
		}
	}

});

