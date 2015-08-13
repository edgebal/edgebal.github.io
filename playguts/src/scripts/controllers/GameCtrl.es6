class GameCtrl {

    constructor($scope, $timeout, $window) {

        Object.assign(this, { $scope, $timeout });

        this.state = {
            epoch: 0
        };

        this._config = {
            fps: 60
        };

        this._setupTimer();

        // TODO: Nice interface to start game (load / new game)

        this.start();

    }

    _setupTimer() {

        this._timer = null;
        this._floatEpoch = 0;

        this._timestamp = ('performance' in window && window.performance.now) ?
            () => window.performance.now() :
            () => Date.now()
        ;

    }

    start() {

        if (!this._timer) {
            this._lastLoop = this._timestamp();
            this.loop();
        }

    }

    stop() {

        if (this._timer) {
            this.$timeout.cancel(this._timer);
            this._timer = null;
        }

    }

    loop() {

        this._timer = this.$timeout(() => {

            let now = this._timestamp(),
                delta = now - this._lastLoop;
            this._lastLoop = now;
            this._floatEpoch += delta;

            this.state.epoch = Math.floor(this._floatEpoch);

            // Next iteration
            this._timer = this.$timeout(() => this.loop(), 0);

        }, 1000 / this._config.fps);

    }

}

GameCtrl.$inject = [ '$scope', '$timeout', '$window' ];
export default GameCtrl;
