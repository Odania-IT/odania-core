app.controller('EditSiteController', ['$location', '$rootScope', '$scope', 'SiteResource', '$routeParams', 'resolveService', function ($location, $rootScope, $scope, SiteResource, $routeParams, resolveService) {
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
		resolveService.resetResolved();
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

	$scope.getCurrentTemplate = function () {
		var currentTemplate = null;

		angular.forEach($rootScope.general.templates, function(template, idx) {
			if (template.template == $scope.site.template) {
				currentTemplate = template;
				return;
			}
		});

		return currentTemplate;
	};

	$scope.saveSite = saveSite;
	$scope.site = {
		'name': '',
		'languages': []
	};

	if ($routeParams.id) {
		siteId = $routeParams.id;
		loadSite($routeParams.id);
	}
}]);
