this.legend_vala_chant_disharmony_effect <- this.inherit("scripts/skills/effects/legend_vala_chant", {
	m = {},

	function create() {
		this.legend_vala_chant.create();
		this.m.Range = 4;
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaChantDisharmonyEffect);
	}

	function calculateBonus(_distance) {
		local bonus = this.m.Vala.getBravery() / 5.0;

		if (this.isMastered()) {
			bonus *= 1.1;
		}
		if (_distance == 2) {
			bonus *= 0.75;
		}
		else if (_distance == 3) {
			bonus *= 0.5;
		}
		else if (_distance == 4) {
			bonus *= 0.25;
		}
		else {
			return 0;
		}
	}

	function getTooltip() {
		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		local bonus = calculateBonus(distance);

		local ret = [ {
			id = 1,
			type = "title",
			text = this.getName()
		}];

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%negative%]-" + this.Math.round(bonus) + "%[/color] Initiative"
		});
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return;
		}
		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		if (!this.checkEntities()) {
			this.updateEffect(false);
			return;
		}

		if (!this.isInRange()) {
			this.updateEffect(false);
			return;
		}

		local bonus = calculateBonus(distance);
		_properties.InitiativeMult *= 1.0 - 0.01 * ::Math.round(bonus);

		this.updateEffect(true);
	}

	function updateEffect(_v) {
		if (_v) {
			this.m.Name = "Disharmony";
			this.m.Icon = "skills/status_effect_65.png";
			this.m.IconMini = "status_effect_65_mini";
			this.m.Overlay = "status_effect_65";
		} else {
			this.getContainer().getActor().m.IsUsingZoneOfControl = true;
			this.m.Name = "";
			this.m.Icon = "";
			this.m.IconMini = "";
			this.m.Overlay = "";
		}
	}

	function onMovementFinished() {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) || !actor.isPlacedOnMap()) {
			return;
		}

		//local distance = actor.getTile().getDistanceTo(this.m.Vala.getTile());
		if (!this.checkEntities()) {
			this.updateEffect(false);
			return;
		}

		if (!this.isInRange()) {
			this.updateEffect(false);
			return;
		}

		this.spawnIcon("status_effect_65", actor.getTile());
		this.updateEffect(true);
	}
});
