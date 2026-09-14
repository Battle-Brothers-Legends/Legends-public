this.legend_stollwurm_blood_flask_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_stollwurm_blood_flask";
		this.m.Name = "Flask of Stollwurm Blood";
		this.m.Description = "This flask holds the blood of a stollwurm, that will grant intense strength and fortitude. Spreading all through your body it will turn your skin to stone for a short time.";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_stollwurm.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 3500;
	}

	function getTooltip()
	{
		local result = this.accessory.getTooltip();
		result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "grants [color=%positive%]50%[/color] damage reduction, and immunity to stun, grab and knockback for three turns"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkStollwurmBlood, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

