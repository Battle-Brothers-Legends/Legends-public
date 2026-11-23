this.legend_RSS_radiance_effect <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeSkillMalus = 0,
		MeleeDefMalus = 0,
		WasBlinded = false
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRssRadianceEffect);
		this.m.Name = "Blinded";
		this.m.Description = "This character is blinded by a radiant light.";
		this.m.Icon = "skills/status_effect_52.png";
		this.m.IconMini = "status_effect_52_mini";
		this.m.Overlay = "status_effect_52";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
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

	function onMovementFinished() {
		local actor = this.getContainer().getActor();
		if (!::Legends.S.isEntityNullOrDead(actor) && actor.isPlacedOnMap()) {
			actor.getSkills().update();
			actor.setDirty(true);
		}
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return;
		}

		local myTile = actor.getTile();
		local isBlindedNow = false;
		local bestMalus1 = 0;
		local bestMalus2 = 0;

		for (local i = 0; i < 6; i = ++i) {
			if (myTile.hasNextTile(i)) {
				local nextTile = myTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor) {
					local entity = nextTile.getEntity();
					if (!entity.isAlliedWith(actor)	&& ::Legends.Effects.has(entity, ::Legends.Effect.LegendRssRadiance)) {
						local skill = ::Legends.Effects.get(entity, ::Legends.Effect.LegendRssRadiance);
						if (skill != null && skill.getItem() != null) {
							isBlindedNow = true;
							bestMalus1 = ::Math.max(bestMalus1, skill.getItem().getRuneBonus1());
							bestMalus2 = ::Math.max(bestMalus2, skill.getItem().getRuneBonus2());
						}
					}
				}

			}
		}

		if (isBlindedNow != this.m.WasBlinded || bestMalus1 != this.m.MeleeSkillMalus || bestMalus2 != this.m.MeleeDefMalus) {
			this.m.WasBlinded = isBlindedNow;
			this.m.MeleeSkillMalus = bestMalus1;
			this.m.MeleeDefMalus = bestMalus2;
			this.m.IsHidden = !isBlindedNow;

			actor.getSkills().update();
			actor.setDirty(true);
		}

		if (this.m.WasBlinded) {
            _properties.MeleeSkillMult *= (1.0 - (this.m.MeleeSkillMalus / 100.0));
            _properties.MeleeDefenseMult *= (1.0 - (this.m.MeleeDefMalus / 100.0));
        }
	}

	function onDeath(_fatalityType) {
		this.removeSelf();
	}

	function onCombatFinished() {
		this.removeSelf();
	}
});
