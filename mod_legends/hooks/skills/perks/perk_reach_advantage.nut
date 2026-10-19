::mods_hookExactClass("skills/perks/perk_reach_advantage", function (o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		local actor = this.getContainer().getActor();
		if (actor.getMainhandItem() == null || !actor.getMainhandItem().isWeaponType(::Const.Items.WeaponType.Staff)) {
			return;
		}
		if (_properties.IsImmuneToSurrounding == true || ::Legends.Perks.has(actor, ::Legends.Perk.Underdog)) {
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		} else {
			_properties.SurroundedDefense += 5; //tbd, doesn't agree with the perk tooltip, needs fixing her and below
		}
	}

	o.onTurnStart = function () {
		this.m.Stacks = ::Math.max(0, this.m.Stacks - 2);
		if (this.m.Stacks == 0) {
			this.m.IsHidden = true;
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Stacks * 5 + "[/color] Melee " + ::Legends.S.inlineIcon(["melee_defense"]);
	}
});
