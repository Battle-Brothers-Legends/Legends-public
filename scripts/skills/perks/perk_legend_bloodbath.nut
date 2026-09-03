this.perk_legend_bloodbath <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBloodbath);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function isHidden() {
		return this.getBleeders() == 0;
	}

	function getTooltip() {
		local count = this.getBleeders();
		local tooltip = this.skill.getTooltip();
		if (count > 0) {
			tooltip.extend([
				{
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "Gain an additional [color=%positive%]+" + count + "%[/color] Melee Skill"
				},
				{
					id = 7,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "Gain an additional [color=%positive%]+" + count + "%[/color] Ranged Skill"
				},
				{
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "[color=%positive%]+" + ::Math.min(count, 5) + "%[/color] Fatigue Recovery per turn"
				}
			]);
		}

		return tooltip;
	}

	function getBleeders() {
		if (!::Tactical.isActive() || ("State" in ::Tactical && ::Tactical.State.isBattleEnded())) {
			return 0;
		}

		if (!("Entities" in ::Tactical) || ::Tactical.Entities == null) {
			return 0;
		}

		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return 0;
		}

		local myTile = actor.getTile();
		if (myTile == null) {
			return 0;
		}

		local bleedingEnemies = ::Tactical.Entities.getAllInstancesAsArray().filter(function (_, _actor) {
			if (!::MSU.isKindOf(_actor, "actor")) {
				return false;
			}
			if (::Legends.S.isEntityNullOrDead(_actor) || !_actor.isPlacedOnMap()) {
				return false;
			}
			if (_actor.isAlliedWith(actor)) {
				return false;
			}
			if (_actor.getTile() == null) {
				return false;
			}
			if (_actor.getSkills() == null) {
				return false;
			}

			return _actor.getSkills().hasEffect(::Legends.Effect.Bleeding) || _actor.getSkills().hasEffect(::Legends.Effect.LegendGrazedEffect)	|| _actor.getSkills().hasSkillOfType(::Const.SkillType.TemporaryInjury);
		});

		local bonus = 0;
		foreach (enemy in bleedingEnemies) {
			bonus += enemy.getTile().getDistanceTo(myTile) > 1 ? 1 : 2;
		}
		return bonus;
	}

	function onUpdate(_properties) {
		local count = this.getBleeders();
		_properties.Bravery += count;
		_properties.FatigueRecoveryRate += ::Math.min(5, count);
		_properties.MeleeSkill += count;
		_properties.RangedSkill += count;
	}

});
