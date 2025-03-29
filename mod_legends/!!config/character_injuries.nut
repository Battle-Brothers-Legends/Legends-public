::Const.Injury.SkeletonHead <- [
	{
		ID = "injury.broken_nose",
		Threshold = 0.25,
		Script = "injury/broken_nose_injury"
	},
	{
		ID = "injury.fractured_skull",
		Threshold = 0.6,
		Script = "injury/fractured_skull_injury"
	},
	{
		ID = "injury.grazed_eye_socket",
		Threshold = 0.5,
		Script = "injury/grazed_eye_socket_injury"
	},
	{
		ID = "injury.severe_concussion",
		Threshold = 0.5,
		Script = "injury/severe_concussion_injury"
	}
];
::Const.Injury.SkeletonBody <- [
	{
		ID = "injury.dislocated_shoulder",
		Threshold = 0.50000000,
		Script = "injury/dislocated_shoulder_injury"
	},
	{
		ID = "injury.fractured_hand",
		Threshold = 0.25000000,
		Script = "injury/fractured_hand_injury"
	},
	{
		ID = "injury.fractured_ribs",
		Threshold = 0.25000000,
		Script = "injury/fractured_ribs_injury"
	},
	{
		ID = "injury.crushed_finger",
		Threshold = 0.25,
		Script = "injury/crushed_finger_injury"
	},
	{
		ID = "injury.fractured_elbow",
		Threshold = 0.25,
		Script = "injury/fractured_elbow_injury"
	},
	{
		ID = "injury.sprained_ankle",
		Threshold = 0.25,
		Script = "injury/sprained_ankle_injury"
	},
	{
		ID = "injury.injured_knee_cap",
		Threshold = 0.5,
		Script = "injury/injured_knee_cap_injury"
	},
	{
		ID = "injury.injured_shoulder",
		Threshold = 0.25,
		Script = "injury/injured_shoulder_injury"
	},
	{
		ID = "injury.exposed_ribs",
		Threshold = 0.35,
		Script = "injury/exposed_ribs_injury"
	},
	{
		ID = "injury.maimed_foot",
		Threshold = 0.75,
		Script = "injury_permanent/maimed_foot_injury"
	},
	{
		ID = "injury.smashed_hand",
		Threshold = 0.5,
		Script = "injury/smashed_hand_injury"
	},
];
::Const.Injury.Cannibal <- [
	{
		ID = "injury.missing_nose",
		Script = "injury_permanent/missing_nose_injury"
	},
	{
		ID = "injury.missing_eye",
		Script = "injury_permanent/missing_eye_injury"
	},
	{
		ID = "injury.missing_ear",
		Script = "injury_permanent/missing_ear_injury"
	},
	{
		ID = "injury.missing_finger",
		Script = "injury_permanent/missing_finger_injury"
	},
	{
		ID = "injury.missing_hand",
		Script = "injury_permanent/missing_hand_injury"
	}
];
::Const.Injury.CampTraining <- [
	{
		ID = "injury.fractured_hand",
		Threshold = 0.25000000,
		Script = "injury/fractured_hand_injury"
	},
	{
		ID = "injury.fractured_ribs",
		Threshold = 0.25000000,
		Script = "injury/fractured_ribs_injury"
	},
	{
		ID = "injury.crushed_finger",
		Threshold = 0.25000000,
		Script = "injury/crushed_finger_injury"
	},
	{
		ID = "injury.fractured_elbow",
		Threshold = 0.25000000,
		Script = "injury/fractured_elbow_injury"
	},
	{
		ID = "injury.sprained_ankle",
		Threshold = 0.25000000,
		Script = "injury/sprained_ankle_injury"
	},
	{
		ID = "injury.bruised_leg",
		Threshold = 0.25000000,
		Script = "injury/bruised_leg_injury"
	},
	{
		ID = "injury.dislocated_shoulder",
		Threshold = 0.50000000,
		Script = "injury/dislocated_shoulder_injury"
	},
	{
		ID = "injury.broken_arm",
		Threshold = 0.50000000,
		Script = "injury/broken_arm_injury"
	},
	{
		ID = "injury.smashed_hand",
		Threshold = 0.50000000,
		Script = "injury/smashed_hand_injury"
	},
	{
		ID = "injury.broken_ribs",
		Threshold = 0.50000000,
		Script = "injury/broken_ribs_injury"
	},
	{
		ID = "injury.broken_leg",
		Threshold = 0.50000000,
		Script = "injury/broken_leg_injury"
	},
	{
		ID = "injury.broken_nose",
		Threshold = 0.25000000,
		Script = "injury/broken_nose_injury"
	},
	{
		ID = "injury.severe_concussion",
		Threshold = 0.50000000,
		Script = "injury/severe_concussion_injury"
	},
	{
		ID = "injury.split_hand",
		Threshold = 0.50000000,
		Script = "injury/split_hand_injury"
	},
	{
		ID = "injury.cut_arm",
		Threshold = 0.25000000,
		Script = "injury/cut_arm_injury"
	},
	{
		ID = "injury.ripped_ear",
		Threshold = 0.25000000,
		Script = "injury/ripped_ear_injury"
	},
	{
		ID = "injury.split_nose",
		Threshold = 0.25000000,
		Script = "injury/split_nose_injury"
	},
	{
		ID = "injury.pierced_cheek",
		Threshold = 0.25000000,
		Script = "injury/pierced_cheek_injury"
	},
	{
		ID = "injury.grazed_neck",
		Threshold = 0.25000000,
		Script = "injury/grazed_neck_injury"
	},
	{
		ID = "injury.injured_shoulder",
		Threshold = 0.25000000,
		Script = "injury/injured_shoulder_injury"
	},
	{
		ID = "injury.pierced_hand",
		Threshold = 0.25000000,
		Script = "injury/pierced_hand_injury"
	},
	{
		ID = "injury.injured_knee_cap",
		Threshold = 0.50000000,
		Script = "injury/injured_knee_cap_injury"
	}
];

::Const.Injury.PermaInjuryToProsthetic <- {};
::Const.Injury.PermaInjuryToProsthetic["injury.broken_elbow_joint"] <- "trait.legend_prosthetic_forearm";
::Const.Injury.PermaInjuryToProsthetic["injury.broken_knee"] <- "trait.legend_prosthetic_leg";
::Const.Injury.PermaInjuryToProsthetic["injury.maimed_foot"] <- "trait.legend_prosthetic_foot";
::Const.Injury.PermaInjuryToProsthetic["injury.missing_ear"] <- "trait.legend_prosthetic_ear";
::Const.Injury.PermaInjuryToProsthetic["injury.missing_eye"] <- "trait.legend_prosthetic_eye";
::Const.Injury.PermaInjuryToProsthetic["injury.missing_finger"] <- "trait.legend_prosthetic_finger";
::Const.Injury.PermaInjuryToProsthetic["injury.missing_hand"] <- "trait.legend_prosthetic_hand";
::Const.Injury.PermaInjuryToProsthetic["injury.missing_nose"] <- "trait.legend_prosthetic_nose";
::Const.Injury.PermaInjuryToProsthetic["injury.aaaa"] <- "trait.aaa";