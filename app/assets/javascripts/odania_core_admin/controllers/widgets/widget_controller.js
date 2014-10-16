app.controller('WidgetController', ['$rootScope', '$scope', 'WidgetResource', '$routeParams', 'eventTypeProvider', function ($rootScope, $scope, WidgetResource, $routeParams, eventTypeProvider) {
	console.log("controller :: WidgetController");

	function loadWidget(id) {
		WidgetResource.get({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function (data) {
			$scope.widget = data;
		});
	}

	loadWidget($routeParams.id);
}]);
