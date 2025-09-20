::FU.Mod.Tooltips.setTooltips({
	ModSettings = {
		Main = {
			Cancel = ::FU.Class.BasicTooltip("Cancel", "Don't save changes."),
			Reset = ::FU.Class.BasicTooltip("Reset", "Resets all settings on this page."),
			Apply = ::FU.Class.BasicTooltip("Apply", "Save all changes from every page without closing the screen."),
			OK = ::FU.Class.BasicTooltip("Save all changes", "Save all changes from every page and close the screen.")
		},
		Element = {
			Tooltip = ::FU.Class.CustomTooltip(@(_data) ::getModSetting(_data.elementModId, _data.settingsElementId).getTooltip(_data))
		},
		Keybind = {
			Popup = {
				Cancel = {
					Title = "Cancel",
					Description = "Don't save changes."
				},
				Add = {
					Title = "Add",
					Description = "Add another keybind."
				},
				OK = {
					Title = "Save",
					Description = "Save changes."
				},
				Modify = {
					Title = "Modify",
					Description = "Modify this keybind."
				},
				Delete = {
					Title = "Delete",
					Description = "Delete this keybind."
				},
			}
		}
	}
});
