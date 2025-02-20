TacticalScreenTopbarEventLogModule.prototype.createDIV = function (_parentDiv)
{
	this.mNormalHeight = '13.0rem';
	this.mExtendedHeight = '40.0rem';

	var grandpa = _parentDiv.parent();
	_parentDiv.css('opacity', '0');

	var newlog = $('<div class="new-log-container"/>');
	grandpa.append(newlog);
	var width = Math.max(200, Math.min(grandpa.parent().width() / 3.5, 800));
	newlog.css('width', width);
	newlog.css('background-size', newlog.width() + " " + newlog.height());

	var self = this;

	// create: container
	this.mContainer = $('<div class="topbar-event-log-module"/>');
	newlog.append(this.mContainer);

	// create: log container
	var eventLogsContainerLayout = $('<div class="l-event-logs-container"/>');
	eventLogsContainerLayout.css('width', newlog.width() - 50);

	this.mContainer.append(eventLogsContainerLayout);
	this.mEventsListContainer = eventLogsContainerLayout.createList(15);
	this.mEventsListScrollContainer = this.mEventsListContainer.findListScrollContainer();

	this.mEventsListContainer.css('background-size', newlog.width() - 65, + " " + newlog.height());

	// create: button
	var layout = $('<div class="l-expand-button"/>');
	this.mContainer.append(layout);
	this.ExpandButton = layout.createImageButton(Path.GFX + Asset.BUTTON_OPEN_EVENTLOG, function ()
	{
		self.expand(!self.mIsExpanded);
	}, '', 6);
	//this.ExpandButton.css('z-index', '9999999');
	this.expand(false);
};
