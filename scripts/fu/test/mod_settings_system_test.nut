// for (local i = 0; i < 5; ++i)
// {
// 	local numPages = 3;
// 	for (local j = 0; j < numPages; ++j)
// 	{
		local testPage = ::FU.Mod.ModSettings.addPage("Page", "Page Name ");
		// add a title
		testPage.addTitle("titleTest", "Test Title");
		// add a divider
		testPage.addDivider("dividertest");

		// create a boolean setting and add a callback on change
		local testBoolean = testPage.addBooleanSetting("TestBool", true, "Test Bool 1");
		testBoolean.addCallback(function(_data = null)
		{
			::logInfo(this.ID + " was changed to " + _data);
		})

		// create a boolean setting and set it to new campaign
		local testBoolean2 = testPage.addBooleanSetting("TestBool2", true, "Test Bool 2");
		testBoolean2.Data.NewCampaign <- true;

		// create a boolean setting and set it to new campaign only
		// this setting will only appear during the new campgin screen
		local testBoolean3 = testPage.addBooleanSetting("TestBool3", true, "Test Bool 3");
		testBoolean2.Data.NewCampaign <- true;
		testBoolean3.Data.NewCampaignOnly <- true;

		// create a range setting
		testPage.addRangeSetting("TestRange", 100, 10, 300, 10);

		// create an enum setting and lock it from changes
		local testEnum = testPage.addEnumSetting("TestEnum" , "goodbye", ["hi", "hello", "goodbye"]);
		testEnum.lock();

		// create a spacer with the dimensions of a normal element
		testPage.addSpacer("TestSpacer1", "35rem", "8rem");

		// create a button setting with a callback to print out the ID when clicked
		local buttonTest = testPage.addButtonSetting("TestButton", "Click Me", null);
		buttonTest.addCallback(function(_data = null){
			::logInfo("Button " + this.ID + " was pressed");
		})

		// create a spacer that spans the page at half height
		testPage.addSpacer("TestSpacer2", "72rem", "4rem");

		// create a string setting
		testPage.addStringSetting("TestString", "String Test", null);

		// create a color picker setting
		testPage.addColorPickerSetting("testRBGA", "20,40,60,1");
// 	}
// }
