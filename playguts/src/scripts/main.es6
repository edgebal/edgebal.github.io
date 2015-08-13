import "babelify/polyfill";
import GameCtrl from './controllers/GameCtrl.es6';

(function main() {

    angular.module('playguts', [])
        .controller('GameCtrl', GameCtrl);

})();
