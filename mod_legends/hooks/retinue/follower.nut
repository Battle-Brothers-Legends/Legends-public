::mods_hookBaseClass("retinue/follower", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.m.RequiredSkills <- [];
	o.m.LinkedBro <- null;
	o.m.WasOwned <- false;

	o.getLinkedBro <- function ()
	{
		return this.m.LinkedBro;
	}

	o.setOwned <- function ()
	{
		this.m.WasOwned = true;
	}

	o.resetLinkedBro <- function ()
	{
		this.m.LinkedBro = null;
	}

	o.getRequirementsForUI <- function ()
	{
		local ret = [];

		foreach (r in this.m.Requirements)
		{
			ret.push(this.cloneValue(r));
		}

		ret.sort(this.sortByPriority);
		return ret;
	}

	o.getCost = function ()
	{
		return this.m.WasOwned ? 0 : this.m.Cost;
	}

	o.onEvaluate = function ()
	{
		foreach (r in this.m.Requirements)
		{
			r.IsSatisfied = r.CheckRequirement();

			if ("UpdateText" in r) r.UpdateText();
		}
	}

	o.isUnlocked = function ()
	{
		local hasSecondary = false;
		local isSecondaryFulfilled = false;

		foreach (r in this.m.Requirements)
		{
			if (r.NotImportant)
			{
				hasSecondary = true;

				if (isSecondaryFulfilled || !r.IsSatisfied) continue;

				isSecondaryFulfilled = true;
				continue;
			}

			// primary requirement (must fulfill this)
			if (!r.IsSatisfied) return false;
		}

		if (hasSecondary) return isSecondaryFulfilled;

		return true;
	}

	o.isEnabled <- function ()
	{
		local hasSecondary = false;
		local isSecondaryFulfilled = false;

		foreach (r in this.m.Requirements)
		{
			// secondary requirement (only need to fulfill one among all secondary requirements)
			if (r.NotImportant)
			{
				hasSecondary = true;

				if (isSecondaryFulfilled || !r.CheckRequirement()) continue;

				isSecondaryFulfilled = true;
				continue;
			}

			// primary requirement (must fulfill this)
			if (!r.CheckRequirement()) return false;
		}

		if (hasSecondary) return isSecondaryFulfilled;

		return true;
	}

	o.addRequirement <- function ( _text, _function, _isNotImportant = false, _afterAddRequirementFunction = null)
	{
		local requirement = {};
		requirement.Text <- _text;
		requirement.IsSatisfied <- false;
		requirement.CheckRequirement <- _function.bindenv(this);
		requirement.NotImportant <- _isNotImportant;

		this.m.Requirements.push(requirement);

		if (typeof _afterAddRequirementFunction == "function") _afterAddRequirementFunction.call(this, requirement);
	}

	o.addSkillRequirement <- function ( _text, _requiredSkills, _isNotImportant = false, _afterAddRequirementFunction = null )
	{
		this.m.RequiredSkills = _requiredSkills;
		this.addRequirement(_text, this.checkRequiredSkills, _isNotImportant, _afterAddRequirementFunction);
	}

	o.checkRequiredSkills <- function ()
	{
		if (this.m.RequiredSkills.len() == 0)
		{
			return true;
		}

		local isCorrectSkill = function( _skill )
		{
			if (this.m.RequiredSkills.find(_skill.getID()) != null) return true;

			return false;
		}

		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.getSkills().getSkillsByFunction(isCorrectSkill.bindenv(this)).len() != 0)
			{
				this.m.LinkedBro = bro;
				break;
			}
		}

		return this.m.LinkedBro != null && this.m.LinkedBro.isAlive();
	}
	// clone the value for the ui, the return table should not contain any function
	o.cloneValue <- function ( _r )
	{
		local ret = clone _r;
		local garbage = [];

		// collect stuffs
		foreach(k, v in ret)
		{
			if (typeof v != "function") continue;

			garbage.push(k);
		}

		// dump stuffs
		foreach(k in garbage)
		{
			ret.rawdelete(k);
		}

	    return ret;
	}

	o.sortByPriority <- function ( _a, _b )
	{
		if (!_a.NotImportant && _b.NotImportant)
		{
			return -1;
		}
		else if (_a.NotImportant && !_b.NotImportant)
		{
			return 1;
		}

		return 0;
	}

});
