import BatteryLabel from './battery.js';
import Volume from './volume.js';
import NetworkIndicator from './network.js';

const Menu = () => Widget.Button({
    class_name: 'button',
    child: Widget.Box({
        class_name: 'button-inside',
        children: [
            NetworkIndicator(),
            Volume(),
            BatteryLabel(),
        ],
    }),
    onPrimaryClick: () => print('Test'),
});

export default Menu;
