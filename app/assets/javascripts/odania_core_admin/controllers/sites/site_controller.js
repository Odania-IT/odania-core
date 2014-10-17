app.controller('SiteController', ['$rootScope', '$scope', 'SiteResource', '$routeParams', 'eventTypeProvider', function ($rootScope, $scope, SiteResource, $routeParams, eventTypeProvider) {
	console.log("controller :: SiteController");

	function loadSite(id) {
		SiteResource.get({id: id}).$promise.then(function (data) {
			$scope.site = data.site;
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadSite($rootScope.currentSite.id);
	});

	loadSite($routeParams.id);
}]);
