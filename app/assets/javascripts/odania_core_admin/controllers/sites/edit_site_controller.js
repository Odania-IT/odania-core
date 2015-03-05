app.controller('EditSiteController', ['$location', '$scope', 'SiteResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, SiteResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditSiteController");
	var siteId = null;

	function loadSite(id) {
		SiteResource.get({id: id}).$promise.then(function (data) {
			$scope.site = data.site;
			$scope.data = data.data;
		});
	}

	function saveSite() {
		if (siteId) {
			SiteResource.update({id: siteId, site: $scope.site}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			SiteResource.save({site: $scope.site}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/sites');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$scope.toggleLanguageSelection = function toggleSelection(languageId) {
		var idx = $scope.site.languages.indexOf(languageId);

		// is currently selected
		if (idx > -1) {
			$scope.site.languages.splice(idx, 1);
		}

		// is newly selected
		else {
			$scope.site.languages.push(languageId);
		}
	};

	$scope.saveSite = saveSite;
	$scope.site = {
		'name': ''
	};

	if ($routeParams.id) {
		siteId = $routeParams.id;
		loadSite($routeParams.id);
	}
}]);
