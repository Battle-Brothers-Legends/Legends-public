this.legend_craftable_schrat_shield <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {
		Stack = 1
	},
	function create()
	{
		this.named_shield.create();
		this.m.ID = "shield.legend_craftable_schrat";
		this.m.Name = "Living Tree Shield";
		this.m.NameList = this.Const.Strings.ShieldNames;
		this.m.Description = "This shield carved out of the remains of a living tree slowly regrows if it sustains any damage. At a glance, it almost looks as if its grotesque face is still moving. Once per battle this shield will regenerate to full if destroyed.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 8;
		this.updateVariant();
		this.m.Value = 1000;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 17;
		this.m.StaminaModifier = -8;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
		this.m.Block = 25;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
		this.randomizeValues();
	}

	function resetStats() {
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 17;
		this.m.StaminaModifier = -8;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
		this.m.Block = 25;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_named_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_named_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_named_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_named_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_named_shield_0" + this.m.Variant + ".png";
	}

	function getTooltip()
	{
		local result = this.shield.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Regenerates itself by up to [color=%positive%]" + this.Math.floor(this.getConditionMax() * 0.2) + "[/color] of maximum durability each turn"
		});
		if (this.m.Stack > 0) {
			result.push({
				id = ,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will regenerate itself to full upon being destroyed"
			});
		}
		return result;
	}

	function onEquip()
	{
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Shieldwall);
		::Legends.Actives.grant(this, ::Legends.Active.KnockBack);
	}

	function onCombatFinished()
	{
		this.setCondition(shield.getConditionMax());	// To discourage the player stalling battles to fully repair this shield
	}

	function applyShieldDamage( _damage, _playHitSound = true )
	{
		if (!this.m.Stack) {
			return this.shield.applyShieldDamage( _damage, _playHitSound)
		}
		if (this.m.Condition == 0) {
			return;
		}
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsSpecializedInShields) {
			_damage = this.Math.max(1, this.Math.ceil(_damage * 0.5));
		}

		local Condition = this.m.Condition;
		Condition = this.Math.maxf(0.0, this.m.Condition - _damage);

		if (Condition == 0) {
			if (this.m.SoundOnDestroyed.len() != 0) {
				this.Sound.play(this.m.SoundOnDestroyed[this.Math.rand(0, this.m.SoundOnDestroyed.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
			this.setCondition(this.getConditionMax());
			
			actor.setDirty(true);

			if (!actor.isHiddenToPlayer()) {
				this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
				this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + "\'s shield regrows to full durability");
			}
		}

	function onCombatStarted () {
		this.m.Stack = 1;
	}

	function onTurnStart() {
		local shieldMissing = this.getConditionMax() - this.getCondition();
		local shieldAdded = this.Math.min(shieldMissing, this.Math.floor(this.getConditionMax() * 0.2));

		if (shieldAdded <= 0) {
			return;
		}

		this.setCondition(shield.getCondition() + shieldAdded);
		local actor = this.getContainer().getActor();
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer()) {
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + "\'s shield restores " + shieldAdded + " durability");
		}
	}

});

