const network = await Service.import('network')
const NetworkIndicator = () => Widget.Box({
    children: [
        Widget.Label({class_name: 'network-under',}).hook(network, self => {
            if (network.wired.internet == "connected" || network.wired.internet == "connecting") {
                self.label = "";
                return;
            } else if (network.wifi.internet == "connected") {
                self.label = "";
                return;
            } else {
                self.label = "";
                return;
            };
        }),

        Widget.Label({class_name: 'network-upper',}).hook(network, self => {
            const normal = {
                100: '',
                66: '',
                33: '',
                0: '',
            };

            const warning = {
                100: '',
                66: '',
                33: '',
                0: '',
            };

            const icon = [ 100, 66, 33, 0 ].find(
                threshold => threshold <= network.wifi.strength
            );

            if (network.wired.internet == "connected") {
                self.label = '';
                return;
            } else if (network.wifi.internet == "connected") {
                self.label = `${normal[icon]}`;
                return;
            } else if (network.wifi.internet == "connecting") {
                if (icon === undefined) {
                    self.label = '';
                    return;
                } else {
                    self.label = `${warning[icon]}`;
                    return;
                };
            } else {
                self.label = "";
                return;
            };
        }),
    ],
});

export default NetworkIndicator;
