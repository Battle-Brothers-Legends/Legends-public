::Const.ItemActionOrder <- {
	First = 0,
	Early = 1000,
	Any = 50000,
	BeforeLast = 60000
	Last = 70000,
	VeryLast = 80000
};

::Const.Damage <- {
	DamageType = {
		None = 0,
		Unknown = 1,
		Blunt = 2,
		Piercing = 3,
		Cutting = 4,
		Burning = 5
	},
	DamageTypeName = [
		"No Injuries",
		"Unknown",
		"Blunt",
		"Piercing",
		"Cutting",
		"Burning"
	],
	DamageTypeInjuries = [
		{
			Head = [],
			Body = []
		},
		{
			Head = [],
			Body = []
		},
		{
			Head = ::Const.Injury.BluntHead,
			Body = ::Const.Injury.BluntBody
		},
		{
			Head = ::Const.Injury.PiercingHead,
			Body = ::Const.Injury.PiercingBody
		},
		{
			Head = ::Const.Injury.CuttingHead,
			Body = ::Const.Injury.CuttingBody
		},
		{
			Head = ::Const.Injury.BurningHead,
			Body = ::Const.Injury.BurningBody
		}
	],

	function addNewDamageType( _damageType, _injuriesOnHead, _injuriesOnBody, _damageTypeName = "" )
	{
		if (_damageType in this.DamageType)
		{
			throw ::FU.Exception.DuplicateKey(_damageType);
		}

		this.DamageType[_damageType] <- this.DamageType.len();

		this.DamageTypeInjuries.push({
			Head = _injuriesOnHead,
			Body = _injuriesOnBody
		});

		if (_damageTypeName = "") _damageTypeName = _damageType;

		this.DamageTypeName.push(_damageTypeName);
	}

	function getDamageTypeName( _damageType )
	{
		return this.DamageTypeName[_damageType];
	}

	function getDamageTypeInjuries( _damageType )
	{
		return this.DamageTypeInjuries[_damageType];
	}

	function setDamageTypeInjuries( _damageType, _injuriesOnHead, _injuriesOnBody )
	{
		local injuries = this.getDamageTypeInjuries(_damageType);

		injuries.Head = _injuriesOnHead;
		injuries.Body = _injuriesOnBody;
	}

	function getApplicableInjuries( _damageType, _bodyPart, _targetEntity = null )
	{
		local injuries = clone (_bodyPart == ::Const.BodyPart.Head ? this.getDamageTypeInjuries(_damageType).Head : this.getDamageTypeInjuries(_damageType).Body);

		if (_targetEntity != null && injuries.len() > 0)
		{
			foreach (injury in _targetEntity.m.ExcludedInjuries)
			{
				if (injuries.find(injury) != null)
				{
					injuries.remove(injury);
				}
			}
		}

		return injuries;
	}
};
