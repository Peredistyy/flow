/**
 * Add Task Controller
 */
projectsList.controller('addTaskController', ['$scope', '$http', '$attrs', '$mediator',
    function ($scope, $http, $attrs, $mediator) {
        $scope.disabled_submit = false;
        $scope.task = {};

        /**
         * Submit form data
         *
         * @param task
         * @param project
         */
        $scope.submit = function (task, project) {
            task.error = undefined == task.title || '' === task.title;

            if (!task.error) {
                $scope.disabled_submit = true;

                $http({
                    method  : $attrs.method,
                    url     : $attrs.action,
                    data    : { task: task, project: project }
                }).success(function(data) {
                    if (data['success']) {
                        task.title = '';
                        $mediator.$emit('create_task', {task: data['task'], project: project});
                    } else {
                        task.error = true;
                    }

                    $scope.disabled_submit = false;
                });
            }
        };
    }
]);