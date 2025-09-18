this.legend_sighthound_armor <- this.inherit("scripts/items/armor/armor", {

	m = { }

	function create() {
		this.armor.create();

		updateVariant();

		m.ID = "armor.body.legend_sighthound_armor";
		m.Name = "Sighthound Armor";
		m.Description = "";
		m.IconLarge = "";
		m.Icon = "";
		m.SlotType = Const.ItemSlot.Body;

		m.ShowOnCharacter = true;

		m.ImpactSound = Const.Sound.ArmorLeatherImpact;

		m.Condition = 55;
		m.ConditionMax = 55;
		m.StaminaModifier = -10;
	}

	function updateVariant() {
		m.Sprite = "bust_dawg_01_armor_01";
		m.SpriteDamaged = "bust_dawg_01_armor_01_damaged";
		m.SpriteCorpse = "bust_dawg_01_armor_01_dead";
	}

})
