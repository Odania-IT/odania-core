app.controller('SitesController', ['$rootScope', '$scope', 'SiteResource', function ($rootScope, $scope, SiteResource) {
	console.log("controller :: SitesController");

	function loadSites() {
		SiteResource.get().$promise.then(function (data) {
			$rootScope.sites = data.sites;
		});
	}

	function getLanguages(site) {
		var menu, language, languages = [];

		for (var i=0 ; i<site.menus.length ; i++) {
			menu = site.menus[i];
			language = $rootScope.getLanguage(menu.language_id);

			if (language) {
				languages.push(language.iso_639_1);
			} else {
				languages.push('- NOT FOUND '+menu.language_id+' -');
			}
		}

		return languages.join(', ')
	}

	function deleteSite(id) {
		SiteResource.delete({id: id}).$promise.then(function () {
			loadSites();
		});
	}

	$scope.getLanguages = getLanguages;
	$scope.deleteSite = deleteSite;

	loadSites();
}]);
