this.legend_rss_radiance_blind_effect <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeSkillMalus = 0,
		MeleeDefMalus = 0,
		WasBlinded = false
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRssRadianceBlind);
		this.m.Description = "This character is blinded by a radiant light.";
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]-" + this.m.MeleeSkillMalus + "%[/color] Melee skill.\n" + "[color=%positive%]-" + this.m.MeleeDefMalus + "%[/color] Melee defense."
			}
		];
	}

	function isHidden() {
		return this.m.MeleeSkillMalus == 0 && this.m.MeleeDefMalus == 0;
	}

	function getBonus() {
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || !::Tactical.isActive()) {
			return 0;
		}

		local myTile = actor.getTile();
		local bestAttackMalus = 0;
		local bestDefMalus = 0;
		foreach (runeUser in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(!::Legends.S.isEntityNullOrDead(_entity) && _entity.isPlacedOnMap() && !_entity.isAlliedWith(actor) && _entity.getTile().getDistanceTo(myTile) == 1 && ::Legends.Effects.has(_entity, ::Legends.Effect.LegendRssRadiance)))) {
			local effect = ::Legends.Effects.get(runeUser, ::Legends.Effect.LegendRssRadiance);
			if (effect != null && effect.getItem() != null) {
				bestAttackMalus = ::Math.max(bestAttackMalus, effect.getItem().getRuneBonus1());
				bestDefMalus = ::Math.max(bestDefMalus, effect.getItem().getRuneBonus2());
			}
		}
		this.m.MeleeSkillMalus = bestAttackMalus;
		this.m.MeleeDefMalus = bestDefMalus;
	}

	function onUpdate(_properties) {
		this.getBonus();
		_properties.MeleeSkillMult *= (1.0 - (this.m.MeleeSkillMalus / 100.0));
		_properties.MeleeDefenseMult *= (1.0 - (this.m.MeleeDefMalus / 100.0));
	}

	function getActorHoverTooltip (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + this.m.MeleeSkillMalus + "%[/color] " + ::Legends.Text.inlineIcons("melee_skill") + " [color=%negative%]-" + this.m.MeleeDefMalus + "%[/color] " + ::Legends.Text.inlineIcons("melee_defense");
	}
});
