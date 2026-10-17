::mods_hookExactClass("skills/effects/overwhelmed_effect", function (o) {
	o.m.Stacks <- 1;

	o.getDescription <- function () {
		return "Overwhelmed with a flurry of attacks to defend against, leaving few openings to effectively attack for %themselves%.";
	}

	o.getName = function () {
		return this.m.Name;
	}

	o.getTooltip = function () {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-" + this.m.Stacks * 5 + "%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-" + this.m.Stacks * 5 + "%[/color] Ranged Skill"
			}
		];
	}

	o.onRefresh = function () {
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsResistantToAnyStatuses && ::Math.rand(1, 100) <= 50) {
			if (!actor.isHiddenToPlayer()) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " resists being overwhelmed thanks to unnatural physiology");
			}

			return;
		}

		++this.m.Stacks;
		this.spawnIcon("status_effect_74", this.getContainer().getActor().getTile());
	}

	o.onUpdate = function (_properties) {
		_properties.MeleeSkillMult = ::Math.maxf(0.0, _properties.MeleeSkillMult - 0.05 * this.m.Stacks);
		_properties.RangedSkillMult = ::Math.maxf(0.0, _properties.RangedSkillMult - 0.05 * this.m.Stacks);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (this.m.Stacks * 5) + "%[/color] " + ::Legends.S.inlineIcon("melee_skill") + ::Legends.S.inlineIcon("ranged_skill");
	}
});
