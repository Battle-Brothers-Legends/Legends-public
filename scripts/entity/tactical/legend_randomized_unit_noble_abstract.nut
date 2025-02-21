this.legend_randomized_unit_noble_abstract <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", { 
	m = {},
	function onInit() 
	{
		this.legend_randomized_unit_abstract.onInit();
        this.getSprite("socket").setBrush("bust_base_military");
	}

    function create()
	{
		this.legend_randomized_unit_abstract.create();     
	}

	function assignRandomEquipment()
	{
        this.legend_randomized_unit_abstract.assignRandomEquipment();

        local banner;
        if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		local surcoat = "surcoat_" + (banner < 10 ? "0" + banner : banner);
		if (::doesBrushExist(surcoat))
		{
			this.m.Surcoat = banner;
			if (this.Math.rand(1, 100) <= 90)
				this.getSprite("surcoat").setBrush(surcoat);
		}
       	else {
       		this.m.Surcoat = null;
       	}

		local armor = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body);
		local tabard = armor.getUpgrade(this.Const.Items.ArmorUpgrades.Tabbard);
		if (tabard != null)
		{
			tabard.setVariant(banner);
			armor.updateAppearance();
		}

		local helmet = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head);
		if (helmet != null)
		{
			if ("setPlainVariant" in helmet) 
			{ 
				helmet.setPlainVariant(); 
			}

			local helmLayer = helmet.getUpgrade(0);
			if(helmLayer != null) 
			{
				switch (helmLayer.getID())
				{
					case "armor.head.legend_helmet_nordic_helm":
					case "armor.head.legend_helmet_conic_helm":
					case "armor.head.legend_helmet_kettle_helm_high":
					case "armor.head.legend_helmet_kettle_helm_med":
					case "armor.head.legend_helmet_flat_top_helm_polished":
					case "armor.head.legend_helmet_flat_top_face_plate":
						helmLayer.setVariant(::Const.FacColors.EliteHelm[banner]);
						break;
					case "armor.head.legend_helmet_kettle_helm_med":
					case "armor.head.legend_helmet_flat_top_helm":
						helmLayer.setVariant(::Const.FacColors.BasicHelm[banner]);
						break;
					case "armor.head.legend_helmet_norman_helm":
						helmLayer.setVariant(::Const.FacColors.NormanHelm[banner]);
						break;
					case "armor.head.legend_helmet_sallet":
						helmLayer.setVariant(::Const.FacColors.EliteSallet[banner]);
						break;
					case "armor.head.legend_helmet_nordic_helm_high":
					case "armor.head.legend_helmet_nordic_helm_low":
						helmLayer.setVariant(::Const.FacColors.NordicHelm[banner]);
						break;
					case "armor.head.legend_helmet_viking_helm":
						helmLayer.setVariant(::Const.FacColors.VikingHelm[banner]);
						break;
				}				
			}

			local faceplate = helmet.getUpgrade(1); // The flat mask
			if(faceplate != null && faceplate.getID() == "armor.head.legend_helmet_faceplate_flat") {
				faceplate.setVariant(::Const.FacColors.EliteMask[banner]);
			}

			local vanityLayer = helmet.getUpgrade(2);
			if (vanityLayer != null)
			{
				switch (vanityLayer.getID())
				{
					case "armor.head.legend_helmet_faction_helmet":	  //The cool helmet on top that isnt a zweihander
					case "armor.head.legend_helmet_faction_helmet_2": //Zweihander hat
						vanityLayer.setVariant(banner)
				}
			}

			helmet.updateAppearance();
		}

		local shield = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (shield != null && "setFaction" in shield)
		{
			shield.setFaction(banner);
			shield.updateAppearance();
		}

		this.m.Items.updateAppearance();
	}

    function setFemale()
    {
        this.setGender(1);
        this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.BarberFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Female;  
    }

    function setMale()
    {
		this.setGender(0);
        this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;  
    }

}); 