this.legend_craftable_greenwood_schrat_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_craftable_greenwood_schrat";
		this.m.Name = "Living Greenwood Tree Shield";
		this.m.Description = "This shield carved out of the remains of a living tree is lighter and sturdier than those made of common wood. At a glance, it almost looks as if its grotesque face is still moving.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 8;
		this.updateVariant();
		this.m.Value = 7000;
		this.m.MeleeDefense = 30;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -14;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_heartwood";
		this.m.SpriteDamaged = "shield_heartwood_damaged";
		this.m.ShieldDecal = "shield_heartwood_destroyed";
		this.m.IconLarge = "shields/inventory_heartwood_shield.png";
		this.m.Icon = "shields/icon_heartwood_shield.png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

		function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		shield.setCondition(shield.getConditionMax());
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local shield = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local shieldMissing = shield.getConditionMax() - shield.getCondition();
		local shieldAdded = this.Math.min(shieldMissing, this.Math.floor(shield.getConditionMax() * 0.1));


		if (shieldAdded <= 0)
		{
			return;
		}

		shield.setCondition(shield.getCondition() + shieldAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

});

