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
		return !this.getContainer().getActor().isOffhandFree();
	}

	function getTooltip() {
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
				type = "text",
				icon = "ui/icons/special.png"
				text = "Will follow up any attack with a punch from their off hand"
			}
		];

		// Unarmed bonuses
		if (this.getContainer().getActor().isMainhandFree()) {
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
		if (!actor.isOffhandFree() || !_skill.isAttack()) {
			return;
		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand) && !actor.isMainhandFree()) {
			return; // or if you are using hand to hand while the mainhand is holding a weapon
		}

		if (!_forFree) {
			::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, function (_skill) {
				if (!::Legends.S.isEntityNullOrDead(actor, _targetEntity) && _targetEntity.isPlacedOnMap()) {
					local skillToUse = this.getHandToHandSkill();
					if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > skillToUse.getMaxRange()) {
						return;
					}

					_skill.executeFollowUpAttack({
						TargetTile = _targetEntity.getTile(),
						Skill = skillToUse
					});
				}
			}.bindenv(this), this);
		}
	}

	function executeFollowUpAttack(_info) {
		if (::Legends.S.isNull(_info.Skill)) {
			::logWarning("legend_ambidextrous: offhand skill is null, cannot execute follow-up attack");
			return;
		}

		::Const.SkillCounter++;
		_info.Skill.m.IsExecutingOffhand = true;
		_info.Skill.useForFree(_info.TargetTile);
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		if (actor.isMainhandFree() && actor.isOffhandFree()) {
			_properties.MeleeDefense += 10;
			_properties.MeleeSkill += 5;
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local result = "Follows up attacks with off-hand";
		if (this.getContainer().getActor().isMainhandFree()) {
			result += ", [color=%positive%]+5[/color] " + ::Legends.Text.inlineIcons("melee_skill") + "[color=%positive%]+10[/color] " + ::Legends.Text.inlineIcons("melee_defense");
		}
		return result;
	}
});
