app.factory('ImageSelectService', ['$q', 'modalService', function ($q, modalService) {
	var modalOptions = {
		controller: 'ImageSelectController',
		templateUrl: config.getTemplatePath('modals/image_select')
	};

	function selectImage() {
		return modalService.showModal(modalOptions)
	}

	return {
		'selectImage': selectImage
	};
}]);
