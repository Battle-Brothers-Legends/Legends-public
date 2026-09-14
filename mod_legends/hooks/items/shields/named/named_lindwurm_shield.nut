::mods_hookExactClass("items/shields/named/named_lindwurm_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.named_shield.randomizeValues();
		this.resetStats();
	}

	o.resetStats <- function ()
	{
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -14;
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
		this.m.Block = 25;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
	}

	o.onShieldHit <- function ( _attacker, _skill )
	{
		if (::Legends.S.isEntityNullOrDead(_attacker)) {
			if (_attacker.getFlags().has("lindwurm")) {
				return;
			}

			if ((_attacker.getFlags().has("body_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Body) <= 0) && (_attacker.getFlags().has("head_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Head) <= 0)) {
				return;
			}

			local poison = ::Legends.Effects.get(_attacker, ::Legends.Effect.LindwurmAcid);

			if (poison == null) {
				::Legends.Effects.grant(_attacker, ::Legends.Effect.LindwurmAcid);
			}
			else {
				poison.resetTime();
			}

			this.spawnIcon("status_effect_78", _attacker.getTile());
		}
	}
});
