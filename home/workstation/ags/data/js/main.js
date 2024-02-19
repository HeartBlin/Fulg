import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import Pfp from './pfp.js';
import Clock from './clock.js';
import Menu from './menu/index.js';
import Workspaces from './workspaces.js'

// Modules in the right section of the bar
const Right = () => Widget.Box({
    hpack: 'end',
    children: [
        Menu(),
        Clock(),
        Pfp(),
    ],
});

// Modules in the center section of the bar
const Center = () => Widget.Box({
    children: [

    ],
});

// Modules in the left section of the bar
const Left = () => Widget.Box({
    children: [
        //Workspaces(),
    ],
});

// The bar
const Bar = ( monitor = 0 ) => Widget.Window({
    name: `bar-${monitor}`,
    class_name: 'taskbar',
    monitor,
    anchor: [ 'bottom', 'left', 'right' ],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
});

export default Bar;
