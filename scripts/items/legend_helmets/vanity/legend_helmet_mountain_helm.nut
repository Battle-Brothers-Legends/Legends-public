this.legend_helmet_mountain_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_helmet_mountain_helm";
		this.m.Name = "Mountain Helm";
		// this.m.NameList = [
		// 	"Helmet of the Mountain"
		// ];
		// this.m.Name = this.m.NameList[this.Math.rand(0, this.m.NameList.len())];
		this.m.Description = "A helmet crafted from the skin and skull of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1, 2];
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 2000;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -2;
		this.m.Vision = 0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Restores 10% helmet armor each turn"
		});
		return result;
	}



	function onCombatFinished()
	{
		this.setCondition(this.m.ConditionMax);
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

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_mountain_helm" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_mountain_helm" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_mountain_helm" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_mountain_helm" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
