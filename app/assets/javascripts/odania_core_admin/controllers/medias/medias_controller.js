app.controller('MediasController', ['$rootScope', '$scope', 'MediaResource', 'eventTypeProvider', '$location', function ($rootScope, $scope, MediaResource, eventTypeProvider, $location) {
	console.log("controller :: MediasController");

	if (!$rootScope.currentSite || !$rootScope.currentMenu) {
		$location.path('/menus');
	}

	function loadMedias() {
		if ($rootScope.currentMenu) {
			MediaResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id}).$promise.then(function (data) {
				$scope.medias = data.medias;
			});
		} else {
			$scope.medias = [];
		}
	}

	function deleteMedia(id) {
		MediaResource.delete({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function () {
			loadMedias();
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadMedias();
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		loadMedias();
	});

	$scope.deleteMedia = deleteMedia;
	$scope.medias = [];

	loadMedias();
}]);
