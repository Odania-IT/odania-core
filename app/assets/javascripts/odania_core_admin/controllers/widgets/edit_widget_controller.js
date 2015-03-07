app.controller('EditWidgetController', ['$location', '$scope', '$rootScope', 'WidgetResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, WidgetResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditWidgetController");
	var widgetId = null;

	WidgetResource.get({siteId: $rootScope.currentSite.id, language_id: $rootScope.currentMenu.language_id}).$promise.then(function (data) {
		console.warn(data);
		$scope.widgets = data.widgets;
	});

	function loadWidget(id) {
		WidgetResource.get({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function (data) {
			$scope.widget = data;

			selectWidget();
		});
	}

	function saveWidget() {
		if (widgetId) {
			WidgetResource.update({siteId: $rootScope.currentSite.id, id: widgetId, widget: $scope.widget}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			WidgetResource.save({siteId: $rootScope.currentSite.id, widget: $scope.widget}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/widgets');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	function selectWidget() {
		var widget;

		for (var i = 0; i < $rootScope.admin.widgets.length; i++) {
			widget = $rootScope.admin.widgets[i];

			if ($scope.widget.template == widget.template) {
				$scope.selectedWidget = widget;
				console.log("widget", $scope.selectedWidget);
				return;
			}
		}
	}

	$scope.saveWidget = saveWidget;
	$scope.selectWidget = selectWidget;
	$scope.prepareKey = function (parameter) {
		console.warn('parameter', parameter, $scope.widget.content[parameter.key]);

		if (!$scope.widget.content[parameter.key]) {
			$scope.widget.content[parameter.key] = [];
		}

		var lastIdx = $scope.widget.content[parameter.key].length - 1;
		if (lastIdx < 0) {
			$scope.widget.content[parameter.key].push({});
			return true;
		}

		if (Object.keys($scope.widget.content[parameter.key][lastIdx]).length > 1) {
			$scope.widget.content[parameter.key].push({});
		}

		return true;
	};
	$scope.widget = {
		'name': '',
		'template': '',
		'language_id': $rootScope.currentMenu.language_id,
		'content': {},
		'is_global': false
	};

	if ($routeParams.id) {
		widgetId = $routeParams.id;
		loadWidget(widgetId);
	}
}]);
