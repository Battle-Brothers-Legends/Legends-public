this.legend_ijirok_helmet <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.legend_ijirok_helmet";
		this.m.Type = ::Const.Items.HelmetUpgrades.Helm;
		this.m.Name = "Helmet of the Ijirok";
		this.m.Description = "Once a barbarian helmet broken in battle, this piece has been bathed in the blood of the legendary Ijirok. Powers beyond your understanding mended it whole again, and will likewise mend any wounds of the wearer as well.";
		this.m.ArmorDescription = "Includes a barbarian helmet bathed in the blood of the legendary Ijirok.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 12000;
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
		this.m.StaminaModifier = -12;
		this.m.Vision = -1;
		this.m.Lower = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Legendary;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_198";
		this.m.SpriteDamaged = "bust_helmet_198_damaged";
		this.m.SpriteCorpse = "bust_helmet_198_dead";
		this.m.Icon = "helmets/inventory_helmet_198.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Heals [color=%positive%]10[/color] hitpoints of the wearer each turn"
		});
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();

		if (actor != null && !actor.isNull() && actor.isAlive())
		{
			actor.setHitpoints(actor.getHitpointsMax());
			actor.setDirty(true);
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = ::Math.min(healthMissing, 10);

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			::Tactical.spawnIconEffect("status_effect_79", actor.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			::Sound.play("sounds/enemies/unhold_regenerate_02.wav", ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

});

