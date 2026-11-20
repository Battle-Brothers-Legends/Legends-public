this.perk_legend_freedom_of_movement <- this.inherit("scripts/skills/skill", {
	m = {
		Skills = [
			::Legends.Actives.getID(::Legends.Active.LegendClimb),
			::Legends.Actives.getID(::Legends.Active.Lunge),
			::Legends.Actives.getID(::Legends.Active.Footwork),
			::Legends.Actives.getID(::Legends.Active.Rotation),
			::Legends.Actives.getID(::Legends.Active.LegendLeap),
			::Legends.Actives.getID(::Legends.Active.LegendHorsePirouette),
			::Legends.Actives.getID(::Legends.Active.LegendEvasion)
		],
		FreeingSkills = [
			::Legends.Active.BreakAllyFree,
			::Legends.Active.BreakFree
		]
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFreedomOfMovement);
	}

	function onAfterUpdate(_properties) {
		foreach (skill in this.m.Skills) {
			_properties.SkillCostAdjustments.push({
				ID = skill,
				FatigueMultAdjust = 0.5
			});
		}

		local actor = this.getContainer().getActor();
		local skills = this.getContainer().getAllSkillsOfType(::Const.SkillType.Active);
		foreach (skill in skills) {
			local id = skill.getID();
			if (this.m.Skills.find(id) != null) {
				if (::Legends.S.oneOf(id, ::Legends.Actives.getID(::Legends.Active.LegendEvasion), ::Legends.Actives.getID(::Legends.Active.LegendLeap))) {
					skill.m.ActionPointCost /= 2;
				} else if (id != ::Legends.Actives.getID(::Legends.Active.Lunge)) {
					if (id != ::Legends.Actives.getID(::Legends.Active.Footwork) || !::Legends.Actives.get(actor, ::Legends.Active.Footwork).m.IsFootwork) {
						skill.m.ActionPointCost -= 1; //LegendClimb, Footwork, Rotation, LegendHorsePirouette
					}
				}
			}
		}

		foreach (skillDef in this.m.FreeingSkills.filter(@(_, _skillDef)(::Legends.Actives.has(actor, _skillDef)))) {
			local skill = ::Legends.Actives.get(actor, skillDef);
			skill.m.ActionPointCost -= 1;
			skill.m.FatigueCostMult *= 0.33;
		}
	}

	function onAdded() {
		if (!this.m.IsNew) {
			return;
		}

		local addPerk = function (_perk, _row = 0) {
			local actor = this.getContainer().getActor();
			if (!actor.isPlayerControlled()) {
				return;
			}

			local bg = actor.getBackground();
			local hasRow = false;
			local direction = -1;
			local row = _row;
			while (row >= 0 && row <= 6) {
				if (bg.m.CustomPerkTree[row].len() < 13) {
					hasRow = true;
					break;
				}

				row += direction;

				if (row == -1) {
					row = _row;
					direction = 1;
				}
			}

			row = hasRow ? ::Math.max(0, ::Math.min(row, 6)) : _row;
			bg.addPerk(_perk, row);
		}

		if (!this.getContainer().hasPerk(::Legends.Perk.LegendTacticalManeuvers)) {
			addPerk(::Const.Perks.PerkDefs.LegendTacticalManeuvers, 5);
		}
		if (!this.getContainer().hasPerk(::Legends.Perk.Footwork)) {
			addPerk(::Const.Perks.PerkDefs.Footwork, 2);
		}
	}
});
