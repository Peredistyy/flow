/**
 * Add Project Controller
 */
projectsList
    .controller('addProjectController', ['$scope', '$http', '$attrs', '$mediator',
        function ($scope, $http, $attrs, $mediator) {
            $scope.toggle = false;

            /**
             * Hide form
             */
            $scope.hide = function () {
                $scope.toggle = false;
                $scope.project.title = '';
            };

            /**
             * Show form
             *
             * @return boolean
             */
            $scope.show = function () {
                var result = false === $scope.toggle;

                $scope.toggle = true;

                return result;
            };

            /**
             * Submit form data
             *
             * @param project
             */
            $scope.submit = function (project) {
                var titleInvalid = (undefined === project || '' === project.title);
                $scope.add_project['project[title]'].$setValidity('required', $scope.show() || !titleInvalid);

                if (!titleInvalid) {
                    $scope.disabled_submit = true;
                    $scope.server_errors = {};

                    $http({
                        method  : $attrs.method,
                        url     : $attrs.action,
                        data    : { project: project }
                    }).success(function(data) {
                        if (data['success']) {
                            $scope.hide();
                            $scope.project.title = '';

                            $mediator.$emit('create_project', data['project']);
                        } else {
                            $scope.server_errors = data['errors'];
                        }

                        $scope.disabled_submit = false;
                    });
                }
            };
        }
    ]);