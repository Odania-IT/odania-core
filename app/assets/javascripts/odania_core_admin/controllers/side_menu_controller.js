app.controller('SideMenuController', ['$rootScope', '$scope', 'eventTypeProvider', function ($rootScope, $scope, eventTypeProvider) {
	console.log("controller :: SideMenuController");
	var resolved = false;

	function changedSite() {
		console.warn("changedSite");
		for (var i = 0; i < $rootScope.sites.length; i++) {
			if ($rootScope.sites[i].id == $scope.current.siteId) {
				$rootScope.currentSite = $rootScope.sites[i];
				$rootScope.currentMenu = $rootScope.currentSite.menus[0];

				if ($rootScope.currentMenu) {
					$scope.current.menuId = $rootScope.currentMenu.id;
				}

				$rootScope.$broadcast(eventTypeProvider.INTERNAL_SITE_CHANGED);
				console.log('currentSite', $rootScope.currentSite);
				return;
			}
		}
	}

	function changedMenu() {
		console.warn("changedMenu");
		for (var i = 0; i < $rootScope.currentSite.menus.length; i++) {
			if ($rootScope.currentSite.menus[i].id == $scope.current.menuId) {
				$rootScope.currentMenu = $rootScope.currentSite.menus[i];
				$rootScope.$broadcast(eventTypeProvider.INTERNAL_MENU_CHANGED);
				console.log('currentMenu', $rootScope.currentMenu);
				return;
			}
		}
	}

	$scope.$on(eventTypeProvider.INTERNAL_BOOTSTRAP_RESOLVED, function processEvent() {
		if (resolved) {
			return;
		}

		if ($rootScope.currentSite) {
			console.log("Setting Site", $rootScope.currentSite);
			$scope.current.siteId = $rootScope.currentSite.id;
		}
		if ($rootScope.currentMenu) {
			console.log("Setting Menu", $rootScope.currentMenu);
			$scope.current.menuId = $rootScope.currentMenu.id;
		}

		resolved = true;
	});

	$rootScope.$watch('currentMenu', function () {
		if ($rootScope.currentMenu) {
			console.log("Setting Menu Watch", $rootScope.currentMenu);
			$scope.current.menuId = $rootScope.currentMenu.id;
		}
	});

	$scope.current = {
		'siteId': null,
		'menuId': null
	};
	$scope.changedSite = changedSite;
	$scope.changedMenu = changedMenu;
}]);
