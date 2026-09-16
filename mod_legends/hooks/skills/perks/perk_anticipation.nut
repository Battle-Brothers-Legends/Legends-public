::mods_hookExactClass("skills/perks/perk_anticipation", function(o) {
	o.m.Stacks <- 1;

	local create = o.create;
	o.create = function () {
		create();
		this.m.IsHidden = true;
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect; 
	}

	o.getDescription <- function () {
		local reduction = ::Math.min(100, ::Math.max(0, this.getContainer().getActor().getCurrentProperties().RangedDefense));
		return "Reduce damage taken by [color=%negative%]" + reduction + "%[/color] for the next [color=%positive%]" + this.m.Stacks + "[/color] hits you take in combat."
	}

	o.onUpdate <- function (_properties) {
		if (!::Tactical.isActive())
			this.m.Stacks = 0;

		if (this.m.Stacks == 0) {
			this.m.IsHidden = true;
			return;
		}
		this.m.IsHidden = false;
		_properties.DamageReceivedTotalMult *= ::Math.minf(1.0, 1.0 - ::Math.max(0, _properties.RangedDefense) * 0.01);
	}

	o.onAfterDamageReceived <- function () {
		this.m.Stacks -= 1;
	}

	o.onBeingAttacked = function ( _attacker, _skill, _properties ) {
	}

	o.onCombatStarted <- function () {
		this.m.Stacks = ::Math.max(1, ::Math.floor(this.getContainer().getActor().getCurrentProperties().Initiative / 100));
	}

	o.onCombatFinished <- function () {
		this.m.Stacks = 0;
	}
});
