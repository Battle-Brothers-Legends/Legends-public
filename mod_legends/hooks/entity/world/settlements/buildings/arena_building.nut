::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o)
{
	o.m.Attempts <- [];

	o.getMaxAttempts <- @() (1 + ((::World.Assets.m.ProfessionEffect.LegendBreadAndGames * 100).tointeger() + ::Math.rand(0, 99)) / 100);
	o.getCurrentAttempts <- @() this.m.Attempts.len();

	o.registerAttempt <- function() {
		this.m.Attempts.push(::World.getTime().Days)
	}

	o.refreshTooltip <- function () {
		this.m.Attempts = this.m.Attempts.filter(@(_, _it) _it == ::World.getTime().Days);
	}

	local refreshCooldown = o.refreshCooldown;
	o.refreshCooldown = function () {
		this.m.Attempts = this.m.Attempts.filter(@(_, _it) _it == ::World.getTime().Days);
		if (this.getCurrentAttempts() == this.getMaxAttempts())
			refreshCooldown();
	}

	o.getAttempts <- function () { // for tooltip
		local maxAttempts = this.getMaxAttempts();
		if(this.isClosed())
			return [0, maxAttempts];
		return [maxAttempts - this.getCurrentAttempts(), maxAttempts];
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out){
		onSerialize(_out);
		_out.writeU8(this.m.Attempts.len());
		foreach (a in this.m.Attempts) {
			_out.writeU32(a);
		}
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function (_in){
		onDeserialize(_in);
		local attempts = _in.readU8();
		this.m.Attempts = [];
		for (local i = 0; i < attempts; i++) {
			this.m.Attempts.push(_in.readU32());
		}
	}


	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list)
	{
		onUpdateDraftList(_list);
		_list.push(::Legends.Background.LegendGladiatorPrizefighter);
		_list.push(::Legends.Background.LegendGladiatorPrizefighter);
	}

	o.onClicked = function (_townScreen) {
		if (!::World.getTime().IsDaytime) {
			return;
		}

		if ((::World.Contracts.getActiveContract() == null || ::World.Contracts.getActiveContract().getType() == "contract.arena" || ::World.Contracts.getActiveContract().getType() == "contract.arena_tournament") && ::World.getTime().Days >= this.m.CooldownUntil)	{
			local f = ::World.FactionManager.getFactionOfType(this.Const.Faction.Arena);
			local contracts = f.getContracts();
			local c;
			if (::World.Contracts.getActiveContract() != null && (::World.Contracts.getActiveContract().getType() == "contract.arena" || ::World.Contracts.getActiveContract().getType() == "contract.arena_tournament")) {
				c = ::World.Contracts.getActiveContract();
			} else if (contracts.len() == 0) {
				if (::World.State.getCurrentTown().hasSituation("situation.arena_tournament") && ::World.Assets.getStash().getNumberOfEmptySlots() >= 5) {
					c = this.new("scripts/contracts/contracts/arena_tournament_contract");
					c.setFaction(f.getID());
					c.setHome(::World.State.getCurrentTown());
					::World.Contracts.addContract(c);
				} else if (::World.Assets.getStash().getNumberOfEmptySlots() >= 3) {
					c = this.new("scripts/contracts/contracts/arena_contract");
					c.setFaction(f.getID());
					c.setHome(::World.State.getCurrentTown());
					::World.Contracts.addContract(c);
				} else {
					return;
				}
			} else {
				if ((!::World.State.getCurrentTown().hasSituation("situation.arena_tournament") && ::World.Assets.getStash().getNumberOfEmptySlots() >= 3) || ::World.Assets.getStash().getNumberOfEmptySlots() >= 5) {
					c = contracts[0];
				} else {
					return;
				}
			}

			c.setScreenForArena();
			::World.Contracts.showContract(c);
		}
	}
});
