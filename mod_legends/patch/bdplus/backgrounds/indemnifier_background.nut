::mods_hookExactClass("skills/backgrounds/indemnifier_background", function(o) {
	o.getTooltip = @() this.character_background.getTooltip();

	o.onBuildDescription = @() "{As with many indemnifiers, %name% was taken at a young age and raised in a barracks with similarly brawny captives. | %name% is an indemnifier, a slave that has repaid their debt to the Gilder and is granted special privileges and combat training in return. | Once an indebted forced to fight in a gladiatorial pit, a wealthy patron saw %name%\'s skill and had the man sent to the indemnifier barracks. | Indemnifiers are slave-knights used as bodyguards, soldiers, and civil servants. %name% is one such man. | For years, %name% toiled in the fields as an indebted. Then a passing vizier took notice of him, and for years more he trained in the barracks as an indemnifier. | %name%\'s scarred body cuts an imposing figure, standing taller and wider than most men you\'ve met. Such is the stock of prisoners that are molded into indemnifiers.} {While the man was paid wages and enjoyed a freedom out of reach for slaves and citizens alike, it was pride and esprit de corps that kept him content in his duties. | The man is wholly unlike the typical slaves of the south, bearing the discipline of a drill sergeant, the faith of a priest, and the composure of a statue. | As with most indemnifiers, the man holds no grudges about his imprisonment, instead embracing his role as an executor of the Gilder\'s will. | He holds a book of scriptures in one hand and a weapon in the other. Both are heavily worn from use. | Clad in heavy armor and shielded by his faith in the Gilder, you\'ve seen fortresses less sturdy than the man before you. | At first embittered by his cruel fate, eventually the man embraced his new role and pursued his duties with an almost unnerving devotion.} {After years of service, some unknown circumstance forced %name% to leave his cohort. He refuses to elaborate on the matter. | As part of his duties, %name% served as a fire fighter. When a city district was set ablaze in the hedonistic carousal of a careless vizier, his entire cohort resigned in disgust. None dared stop them. | While policing the streets, he cut off the hand of a thief who stole from a petitioner. The thief turned out to be the son of a vizier, and the scandal saw %name% quietly expelled from his cohort\'s ranks. He doesn\'t seem to mind, affirmed in the justice of his actions. | One day, his patron was caught in a scandal and made indebted. While most of the estate was confiscated, the retainers were turned loose, and %name% found himself with none to command his loyalty. | He and the others in his cohort were sent to fight a hopeless battle, and %name% was the only survivor. Abandoned by the officer he fought under, the man wandered the deserts for a time before ending up here. He\'s surprisingly circumspect about the situation. | %name%\'s cohort found their patron guilty of heresy and summarily executed him. His successor decided it prudent to simply discharge them without further punishment.} {With no where else to go, he now finds himself in the company of Crownlings and scapegraces. Perhaps this, too, is part of the Gilded path? | While it\'s unusual to find an indemnifier open to sellswording, any band of fighters would benefit from his skill. | Ready for a career change, the indemnifier now seeks the company of mercenaries, though you suspect he\'s more interested in testing his loyalty to the Gilder than finding a new regent on the face of a coin. | The indemnifier approaches you with slow, deliberate movements and introduces himself in a steady voice. This act is enough to send the other men nearby fleeing in panic. Hmm. | Seeking new avenues for battles that shall bring glory to his god\'s name, the indemnifier now finds himself in the company of mercenaries. | Eager to get back to work, the man introduces himself and enthusiastically shakes your hand. Ow.}";

	o.setGender <- function (_gender = -1) {
		if (_gender == -1)
			_gender = this.randomizeHumanGender();
		if (_gender != 1)
			return;

		this.m.BackgroundDescription = "Indemnifiers are proud, highly disciplined women, all too familiar with the rigors of combat and physical labor.";
		this.m.GoodEnding = "%name% the indemnifier eventually left the company, claiming the Gilder\'s will obligated her presence elsewhere. Last you heard, the knightly slave had returned to the south and remains there to this day, serving as a general for one of the city-state armies. Supposedly her authority on martial matters rivals that of the viziers, and on religious matters, that of the high priests.";
		this.m.BadEnding = "%name% the indemnifier eventually left the company, claiming the Gilder\'s will obligated her presence elsewhere. Not long after, she ran afoul a group of manhunters who mistook her for an escaped slave. She willingly gave herself up, believing the courts of the south would clear up the misunderstanding, but she was sent to labor camp with other indebted without ever setting foot in the city. Last you heard, she was lynched by her fellow slaves when she tried to dissuade them from uprising.";

		this.m.Faces = ::Const.Faces.SouthernFemale;
		this.m.Hairs = ::Const.Hair.SouthernFemale;
		this.m.HairColors = ::Const.HairColors.SouthernYoung;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = ::Const.Bodies.SouthernFemale;
		this.m.Names = ::Const.Strings.SouthernFemaleNames;
		this.addBackgroundType(::Const.BackgroundType.Female);
	}

	local onAddEquipment = o.onAddEquipment;
	o.onAddEquipment = function () {
		onAddEquipment();
		local items = this.getContainer().getActor().getItems();

		local body = items.getItemAtSlot(::Const.ItemSlot.Body);
		if (body != null)
			items.unequip(body);
		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.mail_and_lamellar_plating],
			[1, ::Legends.Armor.Southern.southern_long_mail_with_padding],
			[1, ::Legends.Armor.Southern.padded_mail_and_lamellar_hauberk],
			[1, ::Legends.Armor.Standard.mail_hauberk],
			[1, ::Legends.Armor.Standard.lamellar_harness],
			[1, ::Legends.Armor.Standard.scale_armor]
		]));

		local head = items.getItemAtSlot(::Const.ItemSlot.Head);
		if (head != null)
			items.unequip(head);
		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_helmet_with_coif],
			[1, ::Legends.Helmet.Southern.heavy_lamellar_helmet],
			[1, ::Legends.Helmet.Southern.turban_helmet],
			[1, ::Legends.Helmet.Standard.conic_helmet_with_closed_mail]
		]));
	}
});

