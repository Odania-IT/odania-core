app.controller('MediaController', ['$rootScope', '$scope', 'MediaResource', '$routeParams', 'eventTypeProvider', '$location', function ($rootScope, $scope, MediaResource, $routeParams, eventTypeProvider, $location) {
	console.log("controller :: MediaController");

	function loadMedia(id) {
		MediaResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.media = data.media;
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/medias');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/medias');
	});

	loadMedia($routeParams.id);
}]);
