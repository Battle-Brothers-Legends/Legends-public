this.perk_legend_ambidextrous <- this.inherit("scripts/skills/skill", {
	m = {
		offHandSkill = null,
		HandToHand = null,
		ApplicableItems = [
			"shield.legend_named_parrying_dagger",
			"shield.legend_parrying_dagger",
			"shield.buckler",
			"shield.legend_mummy_shield"
		],
	},

	// takes a weakTableRef
	function setOffhandSkill(_a) {
		this.m.offHandSkill = ::MSU.asWeakTableRef(_a);
	}

	function resetOffhandSkill() {
		this.m.offHandSkill = null;
	}

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAmbidextrous);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden() {
		if (!::MSU.isNull(this.m.offHandSkill)) {
			return false;
		}

		local actor = this.getContainer().getActor();
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local hasNet = actor.getCurrentProperties().IsSpecializedInNets
			&& off != null && off.getID().find("throwing_net") != null;

		if (hasNet) {
			return false;
		}
		return !(off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand));
	}

	function getTooltip() {
		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		local ret = [
			{
				id = 1,
				type = "title",
				text = "Fluid" // Since the passive should have a different name than the perk in this case
			},
			{
				id = 2,
				type = "description",
				text = "Fluid like water!\n\nThis character will follow up main hand attacks with an attack from their off hand, if possible."
			}
		];

		local ohSkill = ::MSU.isNull(this.m.offHandSkill) ? this.m.HandToHand : this.m.offHandSkill;
		local blockedOffhand = items.hasBlockedSlot(this.Const.ItemSlot.Offhand);
		if (ohSkill != null && !blockedOffhand) {
			if (::Legends.Weapons.isDualWielding(actor)) {
				ret.push({
					id = 3,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Follow-up attack: [color=%negative%]Disabled[/color]"
				});
			} else {
				ret.push({
					id = 3,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Follow-up attack: [color=%positive%]" + ohSkill.getName() + "[/color]"
				});
			}
		}

		// Unarmed bonuses
		if ((main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed))
			&& off == null
			&& !blockedOffhand)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+5[/color] Melee Skill"
			});
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+10[/color] Melee Defense"
			});
		}

		return ret;
	}

	function onAnySkillExecuted(_skill, _targetTile, _targetEntity, _forFree) {
		local actor = this.getContainer().getActor();
		if (::Legends.Weapons.isDualWielding(actor)) {
			return;
		}

		if (!_skill.m.IsAttack) {
			return; // Don't execute a follow up attack if the first skill is not an attack
		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand)
			&& actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null)
		{
			return; // or if you are using hand to hand while the mainhand is holding a weapon
		}

		if (::Legends.S.skillEntityAliveCheck(actor, _targetEntity)) {
			return;
		}

		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > 1) {
			return; // no gomu gomu h2h attacks
		}

		local items = actor.getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local hasNet = actor.getCurrentProperties().IsSpecializedInNets
			&& off != null && off.getID().find("throwing_net") != null;
		// Don't trigger follow-up if the attack came from the offhand
		if (::Legends.Weapons.isOffHandSkill(actor, _skill)) {
			return;
		}

		if (_targetEntity != null
			&& (!items.hasBlockedSlot(this.Const.ItemSlot.Offhand) || off == null || hasNet || !::MSU.isNull(this.m.offHandSkill)))
		{
			if (!_forFree) {
				if (_targetTile == null || actor.getTile() == null) {
					// Is this necessary?
					return;
				}

				// i need to somehow do this more dynamically
				this.Const.SkillCounter++;
				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.executeFollowUpAttack.bindenv(this), {
					TargetTile = _targetTile,
					Skill = !::MSU.isNull(this.m.offHandSkill)
						? this.m.offHandSkill: this.m.HandToHand
					});
			}
		}
	}

	function executeFollowUpAttack(_info) {
		local entity = _info.TargetTile.getEntity();
		if (::Legends.S.skillEntityAliveCheck(entity)) {
			return;
		}
		if (::MSU.isNull(_info.Skill)) {
			::logWarning("legend_ambidextrous: offhand skill is null, cannot execute follow-up attack");
			return;
		}
		
		_info.Skill.m.IsExecutingOffhand = true;
		_info.Skill.useForFree(_info.TargetTile);
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local hasNet = actor.getCurrentProperties
			&& off != null && off.getID().find("throwing_net") != null;
		if ((main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed))
			&& (off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) || hasNet))
		{
			_properties.MeleeDefense += 10;
			_properties.MeleeSkill += 5;
		}
	}

	function onAdded() {
		if (::Legends.Actives.get(this, ::Legends.Active.LesserFleshGolemAttack))
			this.m.HandToHand = ::MSU.asWeakTableRef(::Legends.Actives.get(this, ::Legends.Active.LesserFleshGolemAttack));
		else if (::Legends.Actives.get(this, ::Legends.Active.GreaterFleshGolemAttack))
			this.m.HandToHand = ::MSU.asWeakTableRef(::Legends.Actives.get(this, ::Legends.Active.GreaterFleshGolemAttack));
		else
			this.m.HandToHand = ::MSU.asWeakTableRef(::Legends.Actives.get(this, ::Legends.Active.HandToHand));

		local off = this.getContainer().getActor().getOffhandItem();
		if (off != null) {
			this.onEquip(off);
		}
	}

	function onEquip(_item) {
		if (this.m.ApplicableItems.find(_item.getID()) == null) {
			return; // not a right one
		}

		setOffhandSkill(_item.getPrimaryOffhandAttack());
	}

	function onUnequip(_item) {
		if (this.m.ApplicableItems.find(_item.getID()) == null) {
			return; // not a right one
		}

		resetOffhandSkill();
	}

});
