this.perk_legend_return_favor <- this.inherit("scripts/skills/skill", {
	m = {
		RangedSkills = [
			::Legends.Active.ShootBolt,
			::Legends.Active.ShootStake,
			::Legends.Active.QuickShot,
			::Legends.Active.ThrowJavelin,
			::Legends.Active.ThrowSpear,
			::Legends.Active.ThrowBalls,
			::Legends.Active.ThrowAxe,
			::Legends.Active.SlingStone,
			::Legends.Active.LegendShootStone,
			::Legends.Active.LegendSlingHeavyStone
		],
		ShieldSkills = [
			::Legends.Active.KnockBack,
			::Legends.Active.LegendBucklerBash
		],
		ShieldRiposteSkillCounter = 0,
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendReturnFavor);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function onMissed(_attacker, _skill) {
		if (_skill.isGarbage() || !_skill.m.IsWeaponSkill || !_skill.isUsingHitchance() || !_skill.isRanged()) {
			return;
		}

		local actor = this.getContainer().getActor();

		if (::Legends.S.isEntityNullOrDead(_attacker, actor)) {
			return;
		}

		local skill = null;
		foreach (s in this.m.RangedSkills) {
			if (::Legends.Actives.has(this, s)) {
				skill = ::Legends.Actives.get(this, s);
				break;
			}
		}

		if (skill == null) {
			return;
		}

		local chance = actor.getCurrentProperties().getRangedDefense();
		local attackerTile = _attacker.getTile();
		local myTile = actor.getTile();

		if (skill.isUsable() && skill.onVerifyTarget(myTile, attackerTile) && skill.isUsableOn(attackerTile, myTile) && ::Math.rand(1, 100) <= chance) {
			local info = {
				User = actor,
				Skill = skill,
				TargetTile = _attacker.getTile()
			};
			local delay = ::Math.max(::Const.Combat.RiposteDelay, skill.m.Delay);
			::Time.scheduleEvent(::TimeUnit.Virtual, delay, this.onCounterFire.bindenv(this), info);
		}
	}

	function onCounterFire(_info) {
		::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_info.User) + " has dodged the attack and is performing a counter attack.");
		return this.skill.onUse(_info.User, _info.TargetTile);
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	function onShieldHitSkills (_skill, _attacker, _shield) {
		if (!::Legends.S.isEntityNullOrDead(_attacker) && !_attacker.isAlliedWith(this) && _attacker.getTile().getDistanceTo(this.getTile()) == 1 && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID() && _skill != null && !_skill.isIgnoringRiposte()) {
			local skill = null;
			foreach (s in this.m.ShieldSkills) {
				if (::Legends.Actives.has(this, s)) {
					skill = ::Legends.Actives.get(this, s);
					break;
				}
			}

			if (skill == null) {
				return;
			}

			if (skill != null) {
				local info = {
					User = this,
					Skill = skill,
					TargetTile = _attacker.getTile()
				};
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.Const.Combat.RiposteDelay, this.onShieldRiposte.bindenv(this), info);
			}
		}
	}

	function onShieldRiposte( _info ) {
		if (!::Legends.S.isEntityNullOrDead(_info.User)) {
			return;
		}

		if (this.m.ShieldRiposteSkillCounter == this.Const.SkillCounter) {
			return;
		}

		this.m.ShieldRiposteSkillCounter = this.Const.SkillCounter;
		_info.Skill.useForFree(_info.TargetTile);
	}

	function getDynamicTooltip(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local rDef = actor.getCurrentProperties().getRangedDefense();
		if (rDef > 0) {
			return [
				{
					id = 3,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=%positive%]%_rdef%%[/color] to return fire on being missed with a ranged attack",
					param = [["_rdef", rDef]]
				}
			];
		} else {
			return [
				{
					id = 3,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "This character's Ranged Defense is too low to offer any benefit"
				}
			];
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local rDef = this.getContainer().getActor().getCurrentProperties().getRangedDefense();
		return (rDef > 0 ? ("[color=%positive%]" + rDef + "%[/color] to return fire on being missed with a ranged attack") : null);
	}
});
