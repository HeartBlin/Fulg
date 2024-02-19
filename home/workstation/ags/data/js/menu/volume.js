import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';

const Volume = () => Widget.Box({
    children: [
        Widget.Label({class_name: 'volume-under',}).hook(Audio,self => {
            if (!Audio.speaker)
                return;

            if (Audio.speaker.volume != 0 && !Audio.speaker.stream.isMuted) {
                self.label = "";
            } else {
                self.label = "";
            };
        }, 'speaker-changed'),

        Widget.Label({class_name: 'volume-upper',}).hook(Audio, self => {
            if (!Audio.speaker)
                return;

            const category = {
                900000: '',
                99: '',
                67: '',
                33: '',
                1: '',
                0: '',
            };

            const icon = Audio.speaker.stream.isMuted ? 900000 : [99, 67, 33, 1, 0].find(
                threshold => threshold <= Audio.speaker.volume * 100
            );

            self.label = `${category[icon]}`;
        }, 'speaker-changed'),
    ],
});

export default Volume;
