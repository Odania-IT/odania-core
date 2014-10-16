app.controller('WidgetsController', ['$rootScope', '$scope', 'WidgetResource', 'eventTypeProvider', function ($rootScope, $scope, WidgetResource, eventTypeProvider) {
	console.log("controller :: WidgetsController");

	function loadWidgets() {
		WidgetResource.get({siteId: $rootScope.currentSite.id}).$promise.then(function (data) {
			$rootScope.widgets = data.widgets;
		});
	}

	function deleteWidget(id) {
		WidgetResource.delete({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function () {
			loadWidgets();
		});
	}

	$scope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadWidgets();
	});

	$scope.deleteWidget = deleteWidget;

	loadWidgets();
}]);
