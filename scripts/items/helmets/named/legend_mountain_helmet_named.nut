this.legend_mountain_helmet_named <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{	//mfdel
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_mountain_helmet_named";
		this.m.Name = "Helmet of the Mountain";
		this.m.NameList = [
			"Mountain\'s Head",
			"Mountain Peak",
			"Peak\'s Dome",
			"Crest\'s Ward",
			"Boulder Helmet",
			"Mountain Mask"
		];
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
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 10000;
		this.m.Condition = 300.0;
		this.m.ConditionMax = 300.0;
		this.m.StaminaModifier = -24;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Legendary;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Repairs [color=%positive%]10%[/color] of its armor each turn"
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
		local helm = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
		local helmMissing = helm.getArmorMax() - helm.getArmor();
		local helmAdded = ::Math.min(helmMissing, ::Math.floor(helm.getArmorMax() * 0.1));


		if (helmAdded <= 0)
		{
			return;
		}

		helm.setArmor(helm.getArmor() + helmAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			::Tactical.spawnIconEffect("status_effect_79", actor.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			::Sound.play("sounds/enemies/unhold_regenerate_02.wav", ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			::Tactical.EventLog.log(::Const.UI.getColorized(this.m.Name, "#1e468f") + " heals for " + helmAdded + " points");
		}
	}

});

