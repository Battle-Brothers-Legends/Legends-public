this.perk_legend_ambidextrous <- this.inherit("scripts/skills/skill", {
	m = {},

	function getHandToHandSkill() {
		local skill = ::Legends.Actives.get(this, ::Legends.Active.LesserFleshGolemAttack);
		if (skill != null) {
			return skill;
		}
		skill = ::Legends.Actives.get(this, ::Legends.Active.GreaterFleshGolemAttack);
		if (skill != null) {
			return skill;
		}
		return ::Legends.Actives.get(this, ::Legends.Active.HandToHand);
	}

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAmbidextrous);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function isHidden() {
		local actor = this.getContainer().getActor();
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		local hasNet = actor.getCurrentProperties().IsSpecializedInNets && off != null && off.getID().find("throwing_net") != null;

		if (hasNet) {
			return false;
		}
		return !(off == null && !items.hasBlockedSlot(::Const.ItemSlot.Offhand));
	}

	function getTooltip() {
		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(::Const.ItemSlot.Mainhand);

		local ret = [
			{
				id = 1,
				type = "title",
				text = "Fluid" // Since the passive should have a different name than the perk in this case
			},
			{
				id = 2,
				type = "description",
				text = "Fluid like water!\n\nThis character will follow up any attack with a punch from their off hand!"
			},
			{
				id = 3,
				type = "special",
				text = "Will follow up any attack with a punch from their off hand"
			}
		];

		local blockedOffhand = items.hasBlockedSlot(::Const.ItemSlot.Offhand);
		// Unarmed bonuses
		if ((main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && off == null && !blockedOffhand) {
			ret.extend([
				{
					id = 4,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=%positive%]+5[/color] Melee Skill"
				},
				{
					id = 5,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=%positive%]+10[/color] Melee Defense"
				}
			]);
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

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand) && actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null) {
			return; // or if you are using hand to hand while the mainhand is holding a weapon
		}

		if (::Legends.S.isEntityNullOrDead(actor, _targetEntity)) {
			return;
		}

		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > 1) {
			return; // no gomu gomu h2h attacks
		}

		local items = actor.getItems();
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		local hasNet = actor.getCurrentProperties().IsSpecializedInNets && off != null && off.getID().find("throwing_net") != null;
		// Don't trigger follow-up if the attack came from the offhand
		if (::Legends.Weapons.isOffHandSkill(actor, _skill)) {
			return;
		}

		if (_targetEntity != null && ((off == null && !items.hasBlockedSlot(::Const.ItemSlot.Offhand)) || hasNet)) {
			if (!_forFree) {
				local skillToUse = this.getHandToHandSkill();
				if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > skillToUse.getMaxRange()) {
					return;
				}

				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, function (_skill) {
					if (::Legends.S.isEntityNullOrDead(_targetEntity) || !_targetEntity.isPlacedOnMap() || _targetEntity.getTile() == null) {
						return;
					}
					::Const.SkillCounter++;
					_skill.executeFollowUpAttack({
						TargetTile = _targetEntity.getTile(),
						Skill = skillToUse
					});
				}.bindenv(this), this);
			}
		}
	}

	function executeFollowUpAttack(_info) {
		local actor = this.getContainer().getActor();
		local entity = _info.TargetTile.getEntity();
		if (::Legends.S.isEntityNullOrDead(entity) || ::Legends.S.isEntityNullOrDead(actor)) {
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
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		local hasNet = actor.getCurrentProperties && off != null && off.getID().find("throwing_net") != null;
		if ((main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && (off == null && !items.hasBlockedSlot(::Const.ItemSlot.Offhand) || hasNet)) {
			_properties.MeleeDefense += 10;
			_properties.MeleeSkill += 5;
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local result = "Follows up attacks with off-hand";
		local main = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if ((main == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed))) {
			result += ", [color=%positive%]+5[/color] " + ::Legends.S.inlineIcon("melee_skill") + "[color=%positive%]+10[/color] " + ::Legends.S.inlineIcon("melee_defense");
		}
		return result;
	}
});
