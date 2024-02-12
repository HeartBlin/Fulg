import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';

// TODO Fan speed selector with this icons    (low to high)

// PFP
const username = Utils.exec('whoami');
const Pfp = () => Widget.Label({
    class_name: 'pfp',
    label: "",
    tooltip_text: `${username}`,
});

// Clock
const Clock = () => Widget.Label({
    class_name: 'clock',
    setup: self => self
        .poll(1000, self => execAsync(['date', '+‏%H:%M\n%d.%m.%Y'])
            .then(date => self.label = date)),
});

// Battery
// Abandon all hope ye who enter here
const BatteryLabel = () => Widget.Label({
    class_name: 'battery',
    setup: self => self
        .poll(1000, self => {
            var value = Utils.exec('cat /sys/class/power_supply/BAT0/capacity');
            const label = [
                [100, ''],
                [90, ''],
                [80, ''],
                [70, ''],
                [60, ''],
                [50, ''],
                [40, ''],
                [30, ''],
                [20, ''],
                [10, ''],
                [0, ''],
            ].find(([threshold]) => threshold <= value)?.[1];

            const labelcharging = [
                [100, ''],
                [90, ''],           
                [80, ''],
                [70, ''],
                [60, ''],
                [50, ''],
                [40, ''],
                [30, ''],
                [20, ''],
                [10, ''],
                [0, ''],
            ].find(([threshold]) => threshold <= value)?.[1];

            if (exec('cat /sys/class/power_supply/ADP0/online') == 1) {
                self.label = `${labelcharging}`;
                self.tooltip_text = `Battery status: ${value}% available (plugged in)`;
            } else {
                self.label = `${label}`;
                self.tooltip_text = `Battery status: ${value}% available`;
            };
        })
});

const Volume = () => Widget.Box({
    class_name: 'volume',
    children: [
        Widget.Label().hook(Audio, self => {
            if (!Audio.speaker)
                return;

            const category = {
                900000: '',
                100: '',
                67: '',
                33: '',
                1: '',
                0: '',
            };

            const icon = Audio.speaker.stream.isMuted ? 900000 : [100, 67, 33, 1, 0].find(
                threshold => threshold <= Audio.speaker.volume * 100
            );

            self.label = `${category[icon]}`;
        }, 'speaker-changed'),
    ],
});

// Modules in the right section of the bar
const Right = () => Widget.Box({
    hpack: 'end',
    children: [
        Volume(),
        BatteryLabel(),
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

import { monitorFile } from 'resource:///com/github/Aylur/ags/utils.js';

monitorFile(
    `${App.configDir}/style.css`,
    function() {
        App.resetCss();
        App.applyCss(`${App.configDir}/style.css`);
    },
);

// Actually show the bar
export default { 
    style: App.configDir + '/style.css',
    windows: [ Bar() ],
};