import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';

const BatteryLabel = () => Widget.Label({
    class_name: 'battery',
}).hook(Battery, self => {
    const normal = {
        100: '',
        90: '',
        80: '',
        70: '',
        60: '',
        50: '',
        40: '',
        30: '',
        20: '',
        10: '',
        0: '',
    };

    const charging = {
        100: '',
        90: '',
        80: '',
        70: '',
        60: '',
        50: '',
        40: '',
        30: '',
        20: '',
        10: '',
        0: '',
    };

    const icon = [ 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0 ].find(
        threshold => threshold <= Battery.percent
    );

    if (Battery.charging) {
        self.label = `${charging[icon]}`;
    } else {
        self.label = `${normal[icon]}`;
    };
});

export default BatteryLabel;
