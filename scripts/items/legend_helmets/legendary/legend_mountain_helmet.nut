this.legend_mountain_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		  this.helmet.create();
		this.m.ID = "armor.head.legend_mountain_helmet";
		this.m.Name = "Helmet of the Mountain";
		this.m.Description = "A helmet crafted from the skin and skull of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.IsIndestructible = false;
		this.m.Variant = 513;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 10000;
		this.m.Condition = 400; //was 300
		this.m.ConditionMax = 400;
		this.m.StaminaModifier = -38; //was -30
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;

	}

	function getTooltip()
	{
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Repairs [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of its armor each turn"
		});
		return result;
	}

	function onCombatFinished()
	{
		this.m.Condition = this.m.ConditionMax;
		this.updateAppearance();
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local helm = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local helmMissing = helm.getArmorMax() - helm.getArmor();
		local helmAdded = this.Math.min(helmMissing, this.Math.floor(helm.getArmorMax() * 0.1));


		if (helmAdded <= 0)
		{
			return;
		}

		helm.setArmor(helm.getArmor() + helmAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_02.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " heals for " + helmAdded + " points");
		}
	}

});

