this.legend_dual_wield_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AmbidextrousBonus = 0.33,
		IsExecutingOffhand = false,
		ExcludedSkills = [],
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDualWield);
		this.m.Name = "Dual Wielding";
		this.m.Description = "This character is wielding two weapons at once. The weight of the other weapon increases fatigue costs and reduces accuracy.";
		this.m.Icon = "skills/status_effect_75.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.ExcludedSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendDoubleSwing),
			// Follow up attack is handled in Lunge's onTeleportDone
			::Legends.Actives.getID(::Legends.Active.Lunge),
		];
	}

	function getTooltip() {
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.m.Name
			},
			{
				id = 2,
				type = "description",
				text = this.m.Description
			}
		];

		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(::Const.ItemSlot.Offhand);

		if (oh != null) {
			local ohSkill = ::Legends.Weapons.findPrimaryAttackSkill(actor, oh);
			local ohWeight = getWeaponWeight(actor, oh);
			if (ohWeight > 0) {
				ret.push({
					id = 3,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Mainhand skills cost [color=%negative%]+" + ohWeight + "[/color] Fatigue and have [color=%negative%]-" + ohWeight + "[/color] Melee Skill"
				});
			}
			if (ohSkill != null) {
				ret.push({
					id = 4,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Mainhand follow-up: [color=%positive%]" + ohSkill.getName() + "[/color]"
				});
			}
		}

		if (mh != null) {
			local mhSkill = ::Legends.Weapons.findPrimaryAttackSkill(actor, mh);
			local mhWeight = getWeaponWeight(actor, mh);
			if (mhWeight > 0) {
				ret.push({
					id = 5,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Offhand skills cost [color=%negative%]+" + mhWeight + "[/color] Fatigue and have [color=%negative%]-" + mhWeight + "[/color] Melee Skill"
				});
			}
			if (mhSkill != null) {
				ret.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Offhand follow-up: [color=%positive%]" + mhSkill.getName() + "[/color]"
				});
			}
		}

		return ret;
	}

	function getWeaponWeight(_actor, _weapon) {
		local weight = -_weapon.getStaminaModifier();
		if (::Legends.Perks.has(_actor, ::Legends.Perk.LegendAmbidextrous)) {
			weight = ::Math.floor(weight * (1 - this.m.AmbidextrousBonus));
		}
		return weight;
	}

	function getOppositeHandWeight(_skill) {
		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		if (::Legends.Weapons.isOffHandSkill(actor, _skill)) {
			return mh != null ? getWeaponWeight(actor, mh) : 0;
		}
		return oh != null ? getWeaponWeight(actor, oh) : 0;
	}

	function onAdded() {
		::Legends.Actives.grant(this, ::Legends.Active.LegendDoubleSwing);
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendDoubleSwing);
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		foreach (skill in actor.getSkills().m.Skills) {
			if (!skill.m.IsAttack || this.m.ExcludedSkills.find(skill.getID()) != null) {
				continue;
			}

			local weight = getOppositeHandWeight(skill);
			if (weight > 0) {
				_properties.SkillCostAdjustments.push({
					ID = skill.getID(),
					FatigueAdjust = weight
				});
			}
		}
	}

	// Melee skill penalty: initiator gets opposite hand's weight,
	// follow-up inherits the same penalty (= its own hand's weight)
	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (!_skill.m.IsAttack) {
			return;
		}
		if (this.m.ExcludedSkills.find(_skill.getID()) != null) {
			return;
		}

		local weight = getOppositeHandWeight(_skill);
		_properties.MeleeSkill -= weight;
		_skill.m.HitChanceBonus -= weight;
	}

	function onAnySkillExecuted(_skill, _targetTile, _targetEntity, _forFree) {

		// Only trigger for attacks
		if (!_skill.m.IsAttack) {
			return;
		}

		// Don't trigger for Double Swing or follow ups (prevents infinite loop)
		if (this.m.ExcludedSkills.find(_skill.getID()) != null || this.m.IsExecutingOffhand) {
			return;
		}

		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);

		// Check target is valid
		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying()) {
			return;
		}

		// Check distance
		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > 1) {
			return;
		}

		// Determine the follow up depending on where the attack came from
		local skillToUse = null;
		if (::Legends.Weapons.isOffHandSkill(actor, _skill)) {
			// Offhand attack, follow up with mainhand
			if (mh != null && !items.hasBlockedSlot(::Const.ItemSlot.Mainhand)) {
				skillToUse = ::Legends.Weapons.findPrimaryAttackSkill(actor, mh);
			}
		} else {
			// Mainhand attack, follow up with offhand
			if (off != null && !items.hasBlockedSlot(::Const.ItemSlot.Offhand)) {
				skillToUse = ::Legends.Weapons.findPrimaryAttackSkill(actor, off);
			}
		}

		// Schedule follow-up attack
		if (!_forFree && skillToUse != null) {
			this.Const.SkillCounter++;
			::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.executeFollowUpAttack.bindenv(this), {
				TargetTile = _targetTile,
				Skill = skillToUse
			});
		}
	}

	function executeFollowUpAttack(_info) {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor)) {
			return;
		}
		local entity = _info.TargetTile.getEntity();
		if (::Legends.S.isEntityNullOrDead(entity)) {
			return;
		}
		if (::MSU.isNull(_info.Skill)) {
			return;
		}
		this.m.IsExecutingOffhand = true;
		_info.Skill.m.IsExecutingOffhand = true;
		_info.Skill.useForFree(_info.TargetTile);
		this.m.IsExecutingOffhand = false;
	}

});
