this.legend_skin_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.legend_skin_armor";
		this.m.Description = "This disgusting design is made by nailing metal pieces to layers of flesh taken from skin ghouls. It smells awful, is quite heavy, and feels as if it is healing itself on to your body.";
		this.m.Name = "";
		this.m.NameList = [
			"Skin suit",
			"Naked armor",
			"Ghoulish bastion",
			"Flayed Bulwark"
		];
		this.m.Variant = 515;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 10000;
		this.m.Condition = 180;
		this.m.ConditionMax = 180; //was 160
		this.m.StaminaModifier = -16;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.armor.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of the hitpoints of the wearer each turn"
		});
		return result;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return;
		}

		if (actor.getHitpoints() > 0)
		{
			actor.setHitpoints(actor.getHitpointsMax());
			actor.setDirty(true);
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, actor.getHitpointsMax() * 0.1);

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}


});

