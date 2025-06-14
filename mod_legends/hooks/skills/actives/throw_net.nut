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

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = getTooltip();
		if (this.m.IsUnholdNet) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be used on stunned unholds only"
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
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local isPlayer = ::MSU.isKindOf(_user, "player");
		local net = _user.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		local target = _targetTile.getEntity();

		if (net != null && target != null && !target.getCurrentProperties().IsImmuneToRoot && isPlayer) { //prevent player from looting enemy nets
			target.getFlags().set("DropNet", true);
			target.getFlags().set("IsByNetCasting", false);
			target.getFlags().set("IsReinforcedNet", false);

			if(_user.getCurrentProperties().IsSpecializedInNetCasting) //Net casting flag
			{
				target.getFlags().set("IsByNetCasting", true);
			}
			if (net.getID().find("reinforced_throwing_net") != null) //Reinforced net flag
			{
				target.getFlags().set("IsReinforcedNet", true);
			}
		}
		local ret = onUse(_user, _targetTile);
		if (this.m.IsUnholdNet && ret != false) {
			local targetEntity = _targetTile.getEntity();
			::Legends.Actives.remove(targetEntity, ::Legends.Active.BreakFree);
			targetEntity.setFaction(::Const.Faction.None);
			targetEntity.m.IsAttackable = false;
			local contract = ::World.Contracts.getActiveContract();
			if (contract != null) {
				contract.m.Flags.increment("CapturedUnholds");
			}
		}
		return ret;

	}

	o.makeUnholdNet <- function () {
		this.m.Description = "Throw a net on stunned unhold to disable them effectively.";
		this.m.IsUnholdNet = true;
	}

	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function (_originTile, _targetTile) {
		local ret = onVerifyTarget(_originTile, _targetTile);
		if (this.m.IsUnholdNet && ret) {
			local target = _targetTile.getEntity();
			if (::isKindOf(target, "unhold") || ::isKindOf(target, "unhold_bog") || ::isKindOf(target, "unhold_frost")) {
//				return target.getSkills().hasEffect(::Legends.Effect.Stunned);
				return true;
			}
			return false;
		}
		return ret;
	}
});
