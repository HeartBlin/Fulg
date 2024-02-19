const Clock = () => Widget.Label({
    class_name: 'clock',
    setup: self => self
        .poll(1000, self => Utils.execAsync(['date', '+‏%H:%M\n%d.%m.%Y'])
            .then(date => self.label = date)),
});

export default Clock;
