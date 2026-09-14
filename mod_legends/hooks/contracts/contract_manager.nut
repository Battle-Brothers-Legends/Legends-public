::mods_hookNewObject("contracts/contract_manager", function(o)
{
	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function( _in )
	{
		onDeserialize(_in);

		foreach( c in this.m.Open )
		{
			if (c.getDescription().len() != 0)
				continue;

			//if (c.m.Flags.has("ContractDescription"))
			//	c.m.Description = c.m.Flags.get("ContractDescription");
			//else
				c.formatDescription();
		}
	}

	o.addContract = function ( _contract, _isNewContract = true )
	{
		if (!_contract.isValid())
		{
			return;
		}

		if (_isNewContract)
		{
			_contract.m.ID = this.generateContractID();
			_contract.m.TimeOut += this.World.getTime().SecondsPerDay * (this.Math.rand(0, 200) - 100) * 0.01;

			_contract.formatDescription();
		}

//		this.logDebug("contract added: " + _contract.getName());

		if (_contract.getFaction() != 0)
		{
			this.World.FactionManager.getFaction(_contract.getFaction()).addContract(_contract);

			if (_isNewContract)
			{
				local faction = ::World.FactionManager.getFaction(_contract.getFaction());
				this.World.FactionManager.getFaction(_contract.getFaction()).setLastContractTime(this.Time.getVirtualTimeF() + ::Const.LegendMod.ContractCooldown.getLastContractTimeDelay(faction));
			}
		}

		this.m.Open.push(_contract);
	}

	o.setActiveContract = function ( _contract, _alreadyStarted = false )
	{
		if (this.m.Active != null)
		{
			return;
		}

		if (!_alreadyStarted)
		{
			local faction = ::World.FactionManager.getFaction(_contract.getFaction());
			::Const.LegendMod.ContractCooldown.updateStreak(faction);
		}

		this.logInfo("contract activated: " + _contract.getName() + " (id: " + _contract.getID() + ")");

		foreach( i, c in this.m.Open )
		{
			if (c == _contract)
			{
				this.m.Open.remove(i);
				break;
			}
		}

		this.m.Active = _contract;
		_contract.setActive(true);
		this.World.State.getWorldScreen().updateContract(this.m.Active);
		this.World.State.getTownScreen().updateContracts();
		this.World.State.getCampScreen().updateContracts();

		if (!_alreadyStarted)
		{
			this.Sound.play("sounds/scribble.wav");
		}
	}

	o.getContractByID <- function ( _id ){
		if(this.m.Active != null && this.m.Active.getID() == _id) return this.m.Active;

		foreach(contract in this.m.Open)
		{
			if(contract.getID() == _id)
			{
				return contract;
			}
		}

		return null;
	}

	local showContract = o.showContract;
	o.showContract = function ( _c ) {
		local isInCamp = ::World.State.getCampScreen().isVisible();
		local worldState = ::World.State.get();
		local originalShowEvent = worldState.showEventScreen;
		if (isInCamp) {
			worldState.showEventScreen = function (_event, _isContract = false, _playSound = true) {
				return worldState.showEventScreenFromCamp(_event, _isContract, _playSound);
			}
		}
		showContract(_c);
		worldState.showEventScreen = originalShowEvent;
	}
});
