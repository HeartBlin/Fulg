import App from 'resource:///com/github/Aylur/ags/app.js';

import BatteryLabel from './battery.js';
import Volume from './volume.js';
import NetworkIndicator from './network.js';

const Menu = () => Widget.Button({
    class_name: 'button ${class_name}',
    child: Widget.Box({
        class_name: 'button-inside',
        children: [
            NetworkIndicator(),
            Volume(),
            BatteryLabel(),
        ],
    }),
});

export default Menu;
