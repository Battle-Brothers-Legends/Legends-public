::Const.Injury.ExcludedInjuries <- {
	function get( _injuries )
	{
		local ret = _injuries.Injuries;

		foreach (extra in _injuries.Include)
		{
			ret.extend(extra.Injuries);
		}

		return ret;
	}

	function add( _name, _injuries, _include = null )
	{
		if (_include == null) _include = [];
		
		if (_name in this)
		{
			foreach (injury in _injuries)
			{
				if (this[_name].Injuries.find(injury) == null)
				{
					this[_name].Injuries.push(injury);
				}
			}

			foreach (entry in _include)
			{
				if (this[_name].Include.find(entry) == null)
				{
					this[_name].Include.push(entry);
				}
			}
		}
		else
		{
			this[_name] <- {
				Include = _include,
				Injuries = _injuries
			}
		}
	}
};

::Const.Injury.ExcludedInjuries.add(
	"Hand",
	[
		"injury.fractured_hand",
		"injury.crushed_finger",
		"injury.smashed_hand",
		"injury.split_hand",
		"injury.pierced_hand",
		"injury.burnt_hands"
	]
);

::Const.Injury.ExcludedInjuries.add(
	"Arm",
	[
		"injury.fractured_elbow",
		"injury.dislocated_shoulder",
		"injury.broken_arm",
		"injury.cut_arm_sinew",
		"injury.cut_arm",
		"injury.split_shoulder",
		"injury.injured_shoulder",
		"injury.pierced_arm_muscles"
	],
	[
		::Const.Injury.ExcludedInjuries.Hand
	]
);

::Const.Injury.ExcludedInjuries.add(
	"Foot",
	[
		"injury.sprained_ankle",
		"injury.cut_achilles_tendon"
	]
);

::Const.Injury.ExcludedInjuries.add(
	"Leg",
	[
		"injury.bruised_leg",
		"injury.broken_leg",
		"injury.cut_leg_muscles",
		"injury.pierced_leg_muscles",
		"injury.injured_knee_cap",
		"injury.burnt_legs"
	],
	[
		::Const.Injury.ExcludedInjuries.Foot
	]
);

::Const.Injury.ExcludedInjuries.add(
	"Face",
	[
		"injury.broken_nose",
		"injury.split_nose",
		"injury.pierced_cheek",
		"injury.deep_face_cut",
		"injury.grazed_eye_socket",
		"injury.burnt_face"
	]
);

::Const.Injury.ExcludedInjuries.add(
	"Head",
	[
		"injury.severe_concussion",
		"injury.fractured_skull",
		"injury.ripped_ear",
		"injury.grazed_neck",
		"injury.cut_throat"
	],
	[
		::Const.Injury.ExcludedInjuries.Face
	]
);
