// Hook the world map menu to add "Upload Company" button
var _createWorldMapMenuButtons = MainMenuModule.prototype.createWorldMapMenuButtons;
MainMenuModule.prototype.createWorldMapMenuButtons = function (_isSavingAllowed, _seed)
{
	_createWorldMapMenuButtons.call(this, _isSavingAllowed, _seed);

	var self = this;
	var row = $('<div class="row"></div>');
	var divider = this.mButtonContainer.find('.divider');
	divider.before(row);
	var buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Upload Company", function ()
	{
		self.notifyBackendUploadCompanyButtonPressed();
	}, '', 4);
};

MainMenuModule.prototype.notifyBackendUploadCompanyButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onUploadCompanyButtonPressed');
};

// Upload handler on the FU connection - receives data from Squirrel and POSTs to the API
FUConnection.prototype.uploadCompanyData = function (_data)
{
	var url = _data.url;
	var payload = JSON.stringify(_data.company);
	var xhttp = new XMLHttpRequest();
	var self = this;

	xhttp.onloadend = function ()
	{
		if (this.status === 200)
		{
			var response = JSON.parse(this.responseText);
			SQ.call(self.mSQHandle, 'onUploadCompanyResult', {
				success: true,
				companyId: response.id,
				message: response.message
			});
		}
		else
		{
			SQ.call(self.mSQHandle, 'onUploadCompanyResult', {
				success: false,
				message: 'Upload failed (HTTP ' + this.status + ')'
			});
		}
	};

	xhttp.ontimeout = function ()
	{
		SQ.call(self.mSQHandle, 'onUploadCompanyResult', {
			success: false,
			message: 'Upload timed out'
		});
	};

	xhttp.onerror = function ()
	{
		SQ.call(self.mSQHandle, 'onUploadCompanyResult', {
			success: false,
			message: 'Network error'
		});
	};

	xhttp.open('POST', url, true);
	xhttp.setRequestHeader('Content-Type', 'application/json');
	xhttp.timeout = 15000;
	xhttp.send(payload);
};

// Fetch a company by ID from the API and send it back to Squirrel
FUConnection.prototype.fetchCompanyById = function (_data)
{
	var url = _data.url + '/company/' + _data.companyId;
	var self = this;
	var xhttp = new XMLHttpRequest();

	xhttp.onloadend = function ()
	{
		if (this.status === 200)
		{
			SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
				success: true,
				company: JSON.parse(this.responseText)
			});
		}
		else
		{
			SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
				success: false,
				message: this.status === 404 ? 'Company not found' : 'Fetch failed (HTTP ' + this.status + ')'
			});
		}
	};

	xhttp.ontimeout = function ()
	{
		SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
			success: false,
			message: 'Request timed out'
		});
	};

	xhttp.onerror = function ()
	{
		SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
			success: false,
			message: 'Network error'
		});
	};

	xhttp.open('GET', url, true);
	xhttp.timeout = 15000;
	xhttp.send();
};

// Fetch a random company by power range from the API
FUConnection.prototype.fetchRandomCompany = function (_data)
{
	var url = _data.url + '/company/random/' + _data.minPower + '/' + _data.maxPower;
	if (_data.version) url += '?version=' + encodeURIComponent(_data.version);
	var self = this;
	var xhttp = new XMLHttpRequest();

	xhttp.onloadend = function ()
	{
		if (this.status === 200)
		{
			SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
				success: true,
				company: JSON.parse(this.responseText)
			});
		}
		else
		{
			SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
				success: false,
				message: this.status === 404 ? 'No company found in that power range' : 'Fetch failed (HTTP ' + this.status + ')'
			});
		}
	};

	xhttp.ontimeout = function ()
	{
		SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
			success: false,
			message: 'Request timed out'
		});
	};

	xhttp.onerror = function ()
	{
		SQ.call(self.mSQHandle, 'onFetchCompanyResult', {
			success: false,
			message: 'Network error'
		});
	};

	xhttp.open('GET', url, true);
	xhttp.timeout = 15000;
	xhttp.send();
};
