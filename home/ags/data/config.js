import App from 'resource:///com/github/Aylur/ags/app.js';
import Bar from './js/main.js';

// This hot reloads scss
function scssWatcher() {
    return Utils.subprocess(
        [
            'inotifywait',
            '--recursive',
            '--event', 'create,modify',
            '-m', App.configDir + '/scss',
        ],
        applyScss,
        () => console.log('need inotify'),
    )
};

// Compiles scss to css
async function applyScss()  {
    const scss = `${App.configDir}/scss/main.scss`;
    const css = `/tmp/main.css`;

    Utils.exec(`sassc ${scss} ${css}`);
    console.log("scss compiled!");

    App.resetCss();
    App.applyCss(`${css}`);
    console.log("Compiled css applied");
};

// Call em both
applyScss();
scssWatcher();

// Actually show the bar
export default {
    windows: [ Bar() ],
};
