app.controller('ContentsController', ['$rootScope', '$scope', 'ContentResource', 'eventTypeProvider', '$location', function ($rootScope, $scope, ContentResource, eventTypeProvider, $location) {
	console.log("controller :: ContentsController");

	if (!$rootScope.currentSite || !$rootScope.currentMenu) {
		$location.path('/menus');
	}

	function loadContents() {
		if ($rootScope.currentMenu) {
			ContentResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id}).$promise.then(function (data) {
				$scope.contents = data.contents;
			});
		} else {
			$scope.contents = [];
		}
	}

	function deleteContent(id) {
		ContentResource.delete({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function () {
			loadContents();
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadContents();
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		loadContents();
	});

	$scope.deleteContent = deleteContent;
	$scope.contents = [];

	loadContents();
}]);
