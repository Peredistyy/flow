var projectsList = angular.module('projectsList', ['ui.bootstrap', 'ui.sortable', 'angularFileUpload']);

/**
 * Mediator
 */
projectsList
    .factory('$mediator', function ($rootScope) {
        return $rootScope.$new(true);
    });

//= require ./lists/projects_list_controller
//= require ./lists/add_project_controller
//= require ./lists/tasks_list_controller
//= require ./lists/add_task_controller
//= require ./lists/comments_list_controller
//= require ./lists/add_comment_controller

/**
 * ProjectsList app initialize
 */
angular.element(document).ready(function() {
    angular.bootstrap(document.getElementById('projectsList'), ['projectsList']);
});