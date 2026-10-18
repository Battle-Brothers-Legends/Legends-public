::mods_hookExactClass("skills/perks/perk_head_hunter", function(o) {
	o.m.HeadHit <- false;
	o.m.HeadHunterStacks <- 0;

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		if (this.m.HeadHunterStacks > 1) {
			this.m.IsHidden = false;
		}
	}
	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Grants [color=%positive%]%_chance%[/color] chance to hit the head and Damage on a hit to the head",
			param = [["_chance", this.m.HeadHunterStacks * 10]]
		});

		return tooltip;
	}

	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		if (_bodyPart == ::Const.BodyPart.Head) {
			this.m.HeadHit = true;
		}
		else {
			this.m.HeadHit = false;
		}
	}

	o.onTargetKilled <- function ( _targetEntity, _skill ) {
		if (this.m.HeadHit && this.m.SkillCount == this.Const.SkillCounter) {
			this.m.HeadHunterStacks += 1;
		}
	}

	local onCombatFinished = o.onCombatFinished;
	o.onCombatFinished = function () {
		onCombatFinished();
		this.m.HeadHunterStacks = 0;
	}

	local onCombatStarted = o.onCombatStarted;
	o.onCombatStarted = function () {
		onCombatStarted();
		this.m.HeadHunterStacks = 0;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		onAnySkillUsed(_skill, _targetEntity, _properties);
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += this.m.HeadHunterStacks * 0.1;
		_properties.HitChance[::Const.BodyPart.Head] += this.m.HeadHunterStacks * 10;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Guaranteed to hit the head if possible";
	}
});
