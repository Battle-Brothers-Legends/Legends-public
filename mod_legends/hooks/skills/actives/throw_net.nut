::mods_hookExactClass("skills/actives/throw_net", function(o)
{
	o.m.IsUnholdNet <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Throw a net on your target in order to prevent them from moving or defending themself effectively.";
		this.m.IsRanged = true;
	}

	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultUtilityTooltip();
		if (this.m.IsUnholdNet) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be used on dazed or baffled unholds only"
			});
		} else {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Some targets can never be caught or ensnared"
			});
		}

		return tooltip;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.IsHidden = !::MSU.isNull(this.getItem()) && this.getItem().isItemType(::Const.Items.ItemType.Net) && this.getItem().m.Ammo <= 0;

		if (_properties.IsSpecializedInNets) {
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}

		if (_properties.IsSpecializedInNetCasting)
			this.m.MaxRange = 5;

		local skill = ::Legends.Perks.get(this, ::Legends.Perk.LegendSpecialistSpearfisher);
		if (skill != null && skill.m.FreeNet)
			this.m.ActionPointCost = 0;
	}

	local onUse = o.onUse;
	o.onUse = function (_user, _targetTile) {
		local target = _targetTile.getEntity();

		if (this.m.IsUnholdNet) {
			target.isAlliedWithPlayer = @()false;
		}

		this.m.Item.consumeAmmo();
		local ret = onUse(_user, _targetTile); // this returns `null` or `false`, bruh
		this.m.Item.drop(_targetTile); // just drop the spent net there

		local properties = _user.getCurrentProperties();
		if (properties.IsSpecializedInNetCasting && ret != false) {
			local chance = properties.getRangedSkill() + properties.getRangedDefense();
			local successes = 1.0;

			for (local i = 0; i < 6; ++i) {
				if (_targetTile.hasNextTile(i)) {
					local next = _targetTile.getNextTile(i);

					if (next.IsOccupiedByActor && ::Math.abs(next.Level - _targetTile.Level) <= 1 && !next.getEntity().isAlliedWithPlayer()) {
						if (::Math.rand(1, 100) < ::Math.floor(chance / (successes + 1.0))) {
							successes += onUse(_user, next) != false ? 1.0 : 0.0;
						}
					}
				}
			}
		}

		if (this.m.IsUnholdNet && ret != false) {
			::Legends.Effects.grant(target, ::Legends.Effect.Sleeping);
			target.setFaction(::Const.Faction.None);
			target.getAIAgent().removeBehavior(::Const.AI.Behavior.ID.BreakFree);
			target.m.IsAttackable = false;
			local contract = ::World.Contracts.getActiveContract();
			if (contract != null) {
				contract.m.Flags.increment("CapturedUnholds");
			}
			return; // returns null, as original does
		}
		return ret;
	}

	o.makeUnholdNet <- function () {
		this.m.Description = "Throw a net on [color=%negative%]Dazed[/color], [color=%negative%]Baffled[/color] or with less than [color=%negative%]25%[/color] Healthpoints Unhold to disable them effectively.";
		this.m.IsUnholdNet = true;
	}

	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function (_originTile, _targetTile) {
		local ret = onVerifyTarget(_originTile, _targetTile);
		if (this.m.IsUnholdNet && ret) {
			// special case for contract unhold nets
			local target = _targetTile.getEntity();
			if (::isKindOf(target, "unhold") || ::isKindOf(target, "unhold_bog") || ::isKindOf(target, "unhold_frost")) {
				return target.getHitpoints() <= target.getHitpointsMax() / 4
					|| target.getSkills().hasEffect(::Legends.Effect.LegendBaffled)
					|| target.getSkills().hasEffect(::Legends.Effect.LegendDazed)
					|| target.getSkills().hasEffect(::Legends.Effect.Dazed);
			}
			return false;
		}
		return ret;
	}
});
