this.legend_davkul_armor <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "armor.body.legend_davkul_armor";
		this.m.Name = "Aspect of Davkul";
		this.m.Description = "A grisly aspect of Davkul, an ancient power not from this world, and the last remnants of %sacrifice% from whose body it has been fashioned. It shall never break, but instead keep regrowing its scarred skin on the spot.";
		this.m.Variant = 81;
		this.updateVariant();
		this.m.ImpactSound = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		];
		this.m.InventorySound = this.m.ImpactSound;
		this.m.Value = 12000;
		this.m.Condition = 190;
		this.m.ConditionMax = 190;
		this.m.StaminaModifier = -11;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function updateVariant()
	{
		this.m.SpriteBack = "bust_body_81";
		this.m.SpriteDamagedBack = "bust_body_81_damaged";
		this.m.SpriteCorpseBack = "bust_body_81_dead";
		this.m.Icon = "legend_armor/icon_named_davkul_armor_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/inventory_named_davkul_armor_01.png";
		this.m.OverlayIconLarge = "legend_armor/inventory_named_davkul_armor_01.png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Regenerates itself by [color=" + this.Const.UI.Color.PositiveValue + "]90[/color] points of durability each turn."
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Regenerates itself by [color=" + this.Const.UI.Color.PositiveValue + "]90[/color] points of durability each turn."
		});
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local bodyAdded = this.Math.minf(body.getArmorMax(), body.getArmor() + 90.0);


		if (bodyAdded <= 0)
		{
			return;
		}

		body.setArmor(body.getArmor() + bodyAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play(this.m.ImpactSound[this.Math.rand(0, len(this.m.ImpactSound)) - 1], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " heals for " + bodyAdded + " points");
		}
	}

	function onCombatFinished()
	{
		this.m.Condition = this.m.ConditionMax;
		this.updateAppearance();
	}

	function onSerialize( _out )
	{
		this.legend_armor_upgrade.onSerialize(_out);
		_out.writeString(this.m.Description);
	}

	function onDeserialize( _in )
	{
		this.legend_armor_upgrade.onDeserialize(_in);
		this.m.Description = _in.readString();
	}

});
